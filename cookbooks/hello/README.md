# hello

This cookbook is a simple example of a cookbook.  When
run with the default recipe it will create some files in `/tmp/hello`,
including the executable `/tmp/hello/show-me` which you can execute or
inspect after the chef-client run.

To run this cookbook, you can use the following command:

```
chef-client -z -o hello
```

To clean up the files it creates, you can run the cleanup recipe:

```
chef-client -z -o hello::cleanup
```

