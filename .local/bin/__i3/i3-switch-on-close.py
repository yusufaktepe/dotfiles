#!/usr/bin/env python3
# Switch to last-used ws (or ws1) when current ws becomes empty

from i3ipc import Connection

i3 = Connection()
workspace_history = []

def on_workspace_focus(conn, event):
    global workspace_history
    current = event.current
    if current:
        name = current.name
        if not workspace_history or workspace_history[-1] != name:
            workspace_history.append(name)
            if len(workspace_history) > 5:
                workspace_history.pop(0)

def has_windows(workspace):
    return bool(workspace.leaves() or workspace.floating_nodes)

def find_workspace_node(tree, name):
    for node in tree.workspaces():
        if node.name == name:
            return node
    return None

def on_window_close(conn, event):
    global workspace_history
    tree = conn.get_tree()
    focused = tree.find_focused()

    if focused:
        focused_ws = focused.workspace()

        if focused_ws and not has_windows(focused_ws):
            for ws_name in reversed(workspace_history[:-1]):
                ws_node = find_workspace_node(tree, ws_name)
                if ws_node and has_windows(ws_node):
                    conn.command(f'workspace {ws_name}')
                    return

            conn.command('workspace 1')

i3.on("workspace::focus", on_workspace_focus)
i3.on("window::close", on_window_close)

i3.main()

