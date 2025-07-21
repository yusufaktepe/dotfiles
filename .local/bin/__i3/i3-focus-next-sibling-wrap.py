#!/usr/bin/env python3

from i3ipc import Connection

def focus_next_sibling():
    focused = Connection().get_tree().find_focused()
    siblings = getattr(focused.parent, 'nodes', []) if focused else []

    if len(siblings) > 1:
        i = siblings.index(focused)
        siblings[(i + 1) % len(siblings)].command('focus')

if __name__ == "__main__":
    focus_next_sibling()
