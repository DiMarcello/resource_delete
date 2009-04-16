#["lambda", "set_firebird_env", "task", "rand", "print", "fu_blksize", "method_undefined", "fu_each_src_dest0", "untrace_var", "symlink", "sub", "fu_mkdir", "when_writing", "sprintf", "rm_rf", "system", "gsub!", "exit", "fu_have_st_ino?", "cp_r", "cd", "remove_instance_variable", "remove_entry_secure", "file_create", "eval", "putc", "fu_default_blksize", "ruby", "remove_file", "remove_const", "set_trace_func", "gsub", "exit!", "mkdir_p", "rake_merge_option", "initialize", "format", "attr_internal_ivar_name", "rmtree", "import", "remove_method", "chop!", "abort", "sleep", "fu_check_options", "safe_ln", "Digest", "select", "remove_entry", "directory", "firebird_db_string", "puts", "trap", "ln_s", "file", "BigDecimal", "remove_dir", "chop", "recent_tests", "chdir", "test", "touch", "undef_method", "at_exit", "chomp!", "load", "verbose", "gem", "iterator?", "fu_output_message", "install", "split_all", "move", "Integer", "gets", "ln_sf", "compare_file", "rake_check_options", "session_table_name", "fork", "chomp", "include", "getwd", "copy_stream", "build_time_zone_list", "fu_have_symlink?", "initialize_copy", "mkpath", "chmod", "alias_method", "catch", "copy_entry", "print_gem_status", "Pathname", "block_given?", "chmod_R", "multitask", "rm", "Float", "loop", "readline", "remove_class_variable", "cp", "callcc", "rake_output_message", "fu_copy_stream0", "pwd", "public", "method_missing", "getc", "included", "makedirs", "sh", "define_method", "uptodate?", "timeout", "chown", "scan", "throw", "current_gems", "identical?", "y", "attr", "remove", "fu_update_option", "namespace", "String", "readlines", "split", "class_variable_get", "gem_original_require", "load_without_new_constant_marking", "fu_stream_blksize", "protected", "syscall", "extended", "drop_database", "ln", "DelegateClass", "global_variables", "attr_reader", "fu_get_uid", "singleton_method_added", "rm_f", "raise", "p", "Array", "fu_each_src_dest", "class_variable_set", "rake_system", "compare_stream", "Rational", "URI", "binding", "fu_world_writable?", "private", "mkdir", "mv", "open", "method_added", "local_database?", "local_variables", "warn", "fu_list", "attr_writer", "fu_get_gid", "create_database", "singleton_method_removed", "rule", "safe_unlink", "fail", "copy_file", "fu_windows?", "cmp", "proc", "fu_stat_identical_entry?", "module_function", "rmdir", "blankslate_original_append_features", "srand", "printf", "method_removed", "trace_var", "link", "__method__", "chown_R", "nowrite", "attr_accessor", "singleton_method_undefined", "desc", "rm_r", "exec", "sub!", "caller", "fu_same?", "copy", "extend_object", "rename_cannot_overwrite_file?"]

module DiMarcello
  module ResourceDelete
    def self.included(base) # :nodoc:
      base.send :alias_method_chain, :action_options_for, :delete
      
      base::Resource::DEFAULT_ACTIONS << :delete
      base::Resource.send :include, Resource
    end
    
    private
    def action_options_for_with_delete(action, resource, method = nil, resource_options = {})
      return action_options_for_without_delete(action, resource, method, resource_options) unless action.to_sym == :delete
      default_options = { :action => action.to_s }
      require_id = !resource.kind_of?(ActionController::Resources::SingletonResource)
      
      default_options.merge(add_conditions_for(resource.conditions, method || :get)).merge(resource.requirements(require_id))
    end
    
    module Resource
      def self.included(base)
        base.send :alias_method_chain, :add_default_actions, :delete
      end
      
      def add_default_actions_with_delete
        add_default_actions_without_delete
        add_default_action(member_methods, :get, :delete)
      end
    end
  end
end
