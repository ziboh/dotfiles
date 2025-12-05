# edit_nvim_remote.nu
# 一个 Nushell 脚本，用于在现有的 Neovim 实例中远程编辑文件，
# 如果找不到服务器，则打开一个新实例。
def main [
    file_name: string,    # 要编辑的文件的路径
    line_number?: int = 0 # (可选) 要跳转到的行号
] {
    # 检查是否设置了 NVIM 环境变量，该变量指向 nvim 服务器的地址。
    if "NVIM" in $env {
        # 服务器正在运行，连接到它。
        let nvim_server = $env.NVIM
        # 1. 发送按键以关闭任何浮动终端（例如 lazygit）。
        nvim --server $nvim_server --remote-send "<C-\\><C-n>:q<CR>"
        # 2. 在远程实例中打开指定的文件。
        nvim --server $nvim_server --remote $file_name
        # 3. 如果指定了行号，则跳转到该行。
        if $line_number > 0 {
            let go_to_line_cmd = $":($line_number)<CR>"
            nvim --server $nvim_server --remote-send $go_to_line_cmd
        }
    } else {
        # 没有服务器在运行，启动一个新的 nvim 实例。
        # 根据条件创建行号参数 `+<number>`。
        # 如果 line_number 为 0 或未提供，则结果为空列表。
        let line_arg = if $line_number > 0 {
            [ $"+($line_number)" ]
        } else {
            []
        }
        # 启动 nvim，使用展开语法 (...) 传入行号参数（如果存在），
        # 然后是文件名。
        nvim ...$line_arg $file_name
    }
}
