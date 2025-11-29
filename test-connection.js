#!/usr/bin/env node

/**
 * Simple database connection test for Supabase integration
 * Run with: flox activate -- node test-connection.js
 */

const { Client } = require('pg');
require('dotenv').config();

async function testConnection() {
  console.log('🔌 Testing Supabase database connection...');
  console.log('==========================================');
  
  // Parse the connection string and modify SSL settings for testing
  const connectionString = process.env.DATABASE_URI.replace('?sslmode=require', '?sslmode=disable');
  
  const client = new Client({
    connectionString: connectionString,
  });

  try {
    console.log('Connecting to database...');
    await client.connect();
    
    console.log('✅ Successfully connected to Supabase!');
    
    // Test a simple query
    const result = await client.query('SELECT version()');
    console.log('📊 Database version:', result.rows[0].version.split(' ')[0]);
    
    // Check if we can create a test table (and clean it up)
    await client.query(`
      CREATE TABLE IF NOT EXISTS connection_test (
        id SERIAL PRIMARY KEY,
        test_message TEXT,
        created_at TIMESTAMP DEFAULT NOW()
      )
    `);
    
    await client.query(`
      INSERT INTO connection_test (test_message) 
      VALUES ('Connection test successful!')
    `);
    
    const testResult = await client.query(`
      SELECT * FROM connection_test 
      ORDER BY created_at DESC 
      LIMIT 1
    `);
    
    console.log('✅ Write test successful:', testResult.rows[0].test_message);
    
    // Clean up
    await client.query('DROP TABLE connection_test');
    console.log('🧹 Cleaned up test table');
    
    await client.end();
    console.log('');
    console.log('🎉 Database connection test passed!');
    console.log('   Your PayloadCMS backend is ready to connect to Supabase.');
    console.log('');
    console.log('Next step: Run ./dev-scripts.sh backend:dev');
    
  } catch (error) {
    console.error('❌ Connection test failed:');
    console.error('Error:', error.message);
    console.log('');
    console.log('🔧 Troubleshooting:');
    console.log('   1. Verify your DATABASE_URI in .env');
    console.log('   2. Check your Supabase project is active');
    console.log('   3. Confirm your database password is correct');
    console.log('   4. Make sure your IP is allowlisted in Supabase');
    console.log('   5. Check Supabase project status at dashboard');
    
    await client.end().catch(() => {}); // Ignore close errors
    process.exit(1);
  }
}

// Check if .env exists
const fs = require('fs');
if (!fs.existsSync('.env')) {
  console.log('❌ .env file not found!');
  console.log('   Run ./setup-supabase.sh first to configure your environment.');
  process.exit(1);
}

// Check if DATABASE_URI is set
if (!process.env.DATABASE_URI) {
  console.log('❌ DATABASE_URI not found in .env file!');
  console.log('   Please check your .env configuration.');
  process.exit(1);
}

testConnection();
