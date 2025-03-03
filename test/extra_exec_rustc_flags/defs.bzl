"""Test transitions to test extra_exec_rustc_flags."""

def _extra_exec_rustc_flags_transition_impl(settings, attr):
    return {
        "//:extra_exec_rustc_flags": attr.extra_exec_rustc_flags,
    }

_extra_exec_rustc_flags_transition = transition(
    implementation = _extra_exec_rustc_flags_transition_impl,
    inputs = [],
    outputs = ["//:extra_exec_rustc_flags"],
)

def _with_extra_exec_rustc_flags_cfg_impl(ctx):
    return [DefaultInfo(files = depset(ctx.files.srcs))]

with_extra_exec_rustc_flags_cfg = rule(
    implementation = _with_extra_exec_rustc_flags_cfg_impl,
    attrs = {
        "extra_exec_rustc_flags": attr.string_list(
            mandatory = True,
        ),
        "srcs": attr.label_list(
            allow_files = True,
            cfg = _extra_exec_rustc_flags_transition,
        ),
        "_allowlist_function_transition": attr.label(
            default = Label("//tools/allowlists/function_transition_allowlist"),
        ),
    },
)

def _with_exec_cfg_impl(ctx):
    return [DefaultInfo(files = depset(ctx.files.srcs))]

with_exec_cfg = rule(
    implementation = _with_exec_cfg_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            cfg = "exec",
        ),
    },
)
