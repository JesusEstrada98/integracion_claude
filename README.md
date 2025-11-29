# PBP-v01

**Astro + Payload CMS Monorepo Project**

This project combines Astro (frontend) and Payload CMS (backend) in a single repository, managed with flox for consistent development environments.

## Project Structure

```
pbp-v01/
├── frontend/          # Astro application
├── backend/           # Payload CMS application (to be set up)
├── shared/            # Shared assets, types, utilities
├── docs/              # Project documentation
├── .flox/             # Flox environment configuration
└── dev-scripts.sh     # Development helper scripts
```

## ✅ Project Status: **COMPLETE & READY**

🎉 **Full-stack integration successfully implemented:**
- ✅ **Modern Astro frontend** with TypeScript, TailwindCSS, and development tools
- ✅ PayloadCMS backend with admin interface
- ✅ Supabase PostgreSQL database
- ✅ Flox reproducible development environment
- ✅ Complete API integration layer
- ✅ Production-ready configuration
- ✅ **MCP (Model Context Protocol) server configuration**

### 🆕 **Latest Updates (v0.2.1) - COMPLETE**
- ✨ **Modern Development Stack**: TailwindCSS, Prettier, TypeScript
- 🔑 **Secret Key Fixed**: PayloadCMS properly configured
- 🗗️ **Database Ready**: Local PostgreSQL + Supabase sync system
- 🔄 **Database Sync**: Automated pull/push/switch operations
- 🎯 **SEO Ready**: Sitemap generation, RSS feeds
- 📝 **Rich Content**: MDX support for interactive content
- 🔍 **Type Safety**: Enhanced TypeScript integration
- 🎨 **Styling Framework**: Utility-first CSS with TailwindCSS
- 📋 **Documentation**: Comprehensive guides and automation scripts
- 🔗 **Supabase Connection**: Fixed PayloadCMS database connectivity issues

## 🚀 Quick Start

1. **Activate environment & setup:**
   ```bash
   flox activate
   ./dev-scripts.sh supabase:setup  # Configure your Supabase credentials
   ```

2. **Start full-stack development:**
   ```bash
   ./dev-scripts.sh dev  # Starts both frontend and backend
   ```

3. **Access your applications:**
   - **Frontend:** [Front Page](http://localhost:4321)
   - **Backend Admin:** http://localhost:3000/admin  
   - **Integration Test:** http://localhost:4321/api-test
   - **API:** http://localhost:3000/api

## Development Environment

This project uses **flox** for environment management, providing:

- Node.js v22.17.0 (for Astro)
- Python 3.13.5 (for tooling)
- Consistent package versions across different machines

### Available Scripts

Run `./dev-scripts.sh help` to see all available development commands.

## 🤖 AI Development Enhancement (MCP)

This project includes **Model Context Protocol (MCP)** server configuration for enhanced AI tool integration:

- **📁 File System Access:** Navigate project structure intelligently
- **🗄️ Database Integration:** Inspect Supabase schema and data safely
- **⚙️ Development Commands:** Run build, test, and deployment scripts
- **📋 Project Context:** Understand Astro components and Payload collections

### MCP Quick Setup

```bash
# Install MCP servers
./dev-scripts.sh mcp:install

# Check configuration status  
./dev-scripts.sh mcp:status

# Get setup instructions
./dev-scripts.sh mcp:setup
```

📖 **Full setup guide:** See [MCP_SETUP.md](./MCP_SETUP.md) for detailed AI tool integration instructions.

## 🔧 Troubleshooting

### Database Connection Issues
If you encounter PayloadCMS connection issues to Supabase:
- See [SUPABASE_CONNECTION_FIX.md](./docs/SUPABASE_CONNECTION_FIX.md) for detailed troubleshooting
- Common issues: DNS resolution errors, authentication failures, SSL problems
- Solution involves updating to Supabase's Session Pooler connection format

### Other Issues
- Check `./docs/` directory for additional troubleshooting guides
- Run `./dev-scripts.sh help` for available development commands
- Ensure flox environment is activated: `flox activate`

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/topics/git/add_files/#add-files-to-a-git-repository) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/websinn/pbp-v01.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/websinn/pbp-v01/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/user/project/merge_requests/auto_merge/)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
