# From NixOS

## Generate Configuration
Assuming you're happy with your existing partition layout, you can generate a
basic NixOS configuration for your system using:
```sh
bud up
```

This will make a new folder `hosts/$(hostname)`, which you can edit to
your liking.

You must then add a host to `nixos.hosts` in flake.nix:
```nix
{
  # ...
  nixos = {
    hosts = {
      /* set host specific properties here */
      NixOS = { };
      $(hostname) = { };
    };
  };
  # ...
}
```

Make sure your `i18n.defaultLocale` and `time.timeZone` are set properly for
your region. Keep in mind that `networking.hostName` will be automatically
set to the name of your host;

Now might be a good time to read the docs on [suites](../concepts/suites.md) and
[profiles](../concepts/profiles.md) and add or create any that you need.

> ##### _Note:_
> While the `up` sub-command is provided as a convenience to quickly set up and
> install a "fresh" NixOS system on current hardware, committing these files is
> discouraged.
>
> They are placed in the git staging area automatically because they would be
> invisible to the flake otherwise, but it is best to move what you need from
> them directly into a host module of your own making, and commit that instead.
# Installation

Once you're ready to deploy `hosts/$(hostname)`:
```sh
bud rebuild $(hostname) switch
```


This calls `nixos-rebuild` with sudo to build and install your configuration.

> ##### _Notes:_
> - Instead of `switch`, you can pass `build`, `test`, `boot`, etc just as with
>   `nixos-rebuild`.


