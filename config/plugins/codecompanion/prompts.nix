{ lib, pkgs }:
{
  plugins.codecompanion.settings.prompt_library = {
    "Smart Paste" = {
      strategy = "inline";
      description = "Paste code smartly";
      opts = {
        short_name = "paste";
      };
      prompts = [
        {
          role = "system";
          content = ''
            You are a smart code paste agent within Neovim.

            ## **Task:** Intelligently integrate content from the user's clipboard into the current buffer.

            ## **Instructions:**

            -   You may receive code in various programming languages or even natural language instructions.
            -   If the clipboard content is in a different language than the current buffer, translate it to the appropriate language smartly.
            -   If the clipboard content contains pseudo code generate code accordingly.
            -   If the clipboard content contains natural language instructions, interpret and follow them to modify the code in the current buffer.
            -   **ONLY** generate the **new** lines of code required for seamless integration.
            -   Ensure the inserted code is syntactically correct and logically consistent with the existing code.
            -   Do **NOT** include surrounding code or line numbers.
            -   Make sure all brackets and quotes are closed properly.

            ## **Output:**

            -   Provide only the necessary lines of code for insertion.
            -   If you can't generate code just return nothing.
            -   Ensure the response is proper and well-formatted.
          '';
        }
        {
          role = "user";
          content.__raw = ''
              function(context)
              local lines = require('codecompanion.helpers.actions').get_code(1, context.line_count, { show_line_numbers = true })
              local selection_info = ""
              local clipboard = vim.fn.getreg '+'

              if context.is_visual then
                selection_info = string.format('Currently selected lines: %d-%d', context.start_line, context.end_line)
              else
                selection_info = string.format('Current cursor line: %d and Current cursor column is %d', context.cursor_pos[1], context.cursor_pos[2])
              end

              return string.format(
                'I have the following code:\n\n```%s\n%s\n```\n\nClipboard content:\n\n```\n%s\n```\n\n%s',
                context.filetype,
                lines,
                clipboard,
                selection_info
              )
            end'';
          opts = {
            contains_code = true;
          };
        }
      ];
    };
    "Text Revision" = {
      strategy = "inline";
      description = "Revise the text";
      opts = {
        mapping = "<leader>rt";
        auto_submit = true;
        user_prompt = false;
        stop_context_insertion = true;
        short_name = "textexpert";
        placement = "replace";
      };
      prompts = [
        {
          role = "system";
          content = "You are a senior text editor specializing in improving written content. Your tasks include: correcting grammar and spelling errors, improving sentence structure, enhancing clarity and flow, making text sound more natural to native speakers, and ensuring proper Markdown formatting. Provide specific explanations for significant changes, maintain the author's original meaning and tone, and focus on making text professional and polished. When possible, offer brief alternative phrasings for improved sections.";
        }
        {
          role = "user";
          content.__raw = ''
            function(context)
              local lines = require('codecompanion.helpers.actions').get_code(1, context.line_count, { show_line_numbers = true })
              local selection_info = ""
              local clipboard = vim.fn.getreg '+'

              if context.is_visual then
                selection_info = string.format('Currently selected lines: %d-%d', context.start_line, context.end_line)
              else
                selection_info = string.format('Currently selected lines: %d-%d', 1, context.line_count)
              end

              return string.format(
                'I have the following text:\n\n```%s\n%s\n```\n\n%s',
                context.filetype,
                lines,
                selection_info
              )
            end'';
        }
      ];
    };
    "Diff code review" = {
      strategy = "chat";
      description = "Perform a code review";
      opts = {
        auto_submit = true;
        user_prompt = false;
      };
      prompts = [
        {
          role = "user";
          content.__raw = ''
            function()
              local target_branch = vim.fn.input("Target branch for merge base diff (default: main): ", "main")

              return string.format(
                [[
                You are a senior software engineer performing a code review. Analyze the following code changes.
                 Identify any potential bugs, performance issues, security vulnerabilities, or areas that could be refactored for better readability or maintainability.
                 Explain your reasoning clearly and provide specific suggestions for improvement.
                 Consider edge cases, error handling, and adherence to best practices and coding standards.
                 Here are the code changes:
                 ```
                  %s
                 ```
                 ]],
                vim.fn.system("git diff --merge-base " .. target_branch)
              )
            end
          '';
        }
      ];
    };
    "Make asset" = {
      strategy = "chat";
      description = "Create note for my asset";
      opts = {
        auto_submit = true;
        user_prompt = false;
      };
      prompts = [
        {
          role = "user";
          content.__raw = ''
            function()
              local note = vim.fn.system('${lib.getExe pkgs.zk} new')
              local template = 'make following fields in frontmatter (replace example values):\n\n'
                .. '```yaml\n'
                .. 'title: "Apple TV 4K"\n'
                .. 'model: "Apple TV 4K (3rd generation)"\n'
                .. 'status: "active"  # active, inactive, stored, loaned, maintenance, backup, deprecated, broken, warranty-claim, sold, donated, disposed, lost, stolen, returned\n\n'
                .. 'purchase:\n'
                .. '  date: 2025-01-16\n'
                .. '  price: 4 595 CZK\n'
                .. '  vendor:\n'
                .. '    name: "Alza"\n'
                .. '  order_id: 534584506\n\n'
                .. 'manufacturer:\n'
                .. '  name: "Apple"\n'
                .. 'serial_number: null\n\n'
                .. 'warranty:\n'
                .. '  expires: 2027-01-16\n'
                .. '  documents: null\n\n'
                .. 'location: "living room"\n\n'
                .. 'tags:\n'
                .. '  - asset\n'
                .. '  - electronics\n'
                .. '  - entertainment\n'
                .. '```\n\n'

              local task = 'You are an expert notes writer.\n'
                .. 'Your task is to help the user create well-structured note to track their assets.\n\n'
                .. note
                return template .. task
            end
          '';
        }
      ];
    };
  };
}
