# MCP Servers Playground

This repository demonstrates how to integrate the three [ModelContextProtocol SDK](https://github.com/modelcontextprotocol) repositories as Git submodules under the `modelcontextprotocol` directory so that you can use them.

The reason I created this with its submodules is to have a context base for when developing a new MCP server. This will provide a sort of *memory* of the SDKs and servers to any AI tool that may be used to develop a new MCP server.

## Repositories

1. SDK Repositories
    - **Main repo**: https://github.com/pandego/mcp-servers-playground.git
    - **Python SDK**: https://github.com/modelcontextprotocol/python-sdk.git
    - **TypeScript SDK**: https://github.com/modelcontextprotocol/typescript-sdk.git

2. Maintained MCP Servers
    - **Servers**: https://github.com/modelcontextprotocol/servers.git

---

## Setup

### Simple Setup

You can simple run the script `setup.sh` to the entire repository and its submodules, briefly:

1. Copy the `example.env` file to `.env`:
    ```bash
    cp example.env .env
    ```

2. Update the `.env` file with your environment variables.

3. Run the setup script:

    ```bash
    sh ./setup.sh
    ```

**Notes**:
- Those are the servers that I personally use but feel free to adapt this script to your needs.
- This will also setup the Docker images for you, which I prefer.

**TODO**: In the future I will add them all to a compose file with profile for organization.

### Manual Setup

If you prefer to set up the submodules manually, follow these steps:

#### Cloning with Submodules

- To clone this repository along with all submodules in one step:

    ```bash
    git clone --recurse-submodules https://github.com/pandego/mcp-servers-playground.git
    cd mcp-servers-playground
    ```

- If you already have a clone without submodules initialized:

    ```bash
    git submodule update --init --recursive
    ```

#### Updating Submodules

- To pull the latest updates in both the main repo and its submodules:

    ```bash
    git pull --recurse-submodules
    git submodule update --remote --merge
    ```

- Alternatively, use:

    ```bash
    git pull
    git submodule foreach 'git pull origin main'
    ```

## How to setup git submodules

This is just for reference, you can skip this section. This is how I added the submodules to this repository:

1. Create the `modelcontextprotocol` directory:

    ```bash
    mkdir -p modelcontextprotocol
    ```

2. Add the submodules:

    ```bash
    git submodule add https://github.com/modelcontextprotocol/python-sdk.git modelcontextprotocol/python-sdk
    git submodule add https://github.com/modelcontextprotocol/typescript-sdk.git modelcontextprotocol/typescript-sdk
    git submodule add https://github.com/modelcontextprotocol/servers.git modelcontextprotocol/servers
    ```

3. Commit the changes:

    ```bash
    git commit -m "[FEAT] add submodules: python-sdk, typescript-sdk, servers"
    ```

## License

This repository is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## References

1. [Model Context Protocol](https://github.com/modelcontextprotocol)
2. [MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk)
3. [MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
4. [MCP Servers](https://github.com/modelcontextprotocol/servers)
