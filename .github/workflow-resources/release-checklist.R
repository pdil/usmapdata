release_checklist <- function(email, token, version) {
    # Reverse dependency checks
    revdepcheck::revdep_reset()
    revdepcheck::revdep_check()

    # Version number updates
    desc::desc_set_version(version)
}
