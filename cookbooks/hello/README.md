# hello

When run with the default recipe, this cookbook will create some files in `/tmp/hello`, including the executable `/tmp/hello/show-me` which you can execute or inspect after the chef-client run.

To apply this cookbook, you can use the following command:

```
chef-client -z -o hello
```

To clean up the files and directory it created, you can apply the cleanup recipe:

```
chef-client -z -o hello::cleanup
```

