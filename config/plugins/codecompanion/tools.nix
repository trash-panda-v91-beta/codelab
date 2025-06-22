{
  plugins.codecompanion.settings.strategies.chat.tools = {
    calculator = {
      description = "Perform calculations";
      callback = {
        name = "calculator";
        cmds = {
          __unkeyed.__raw = ''
            function(self, args, input)
              local num1 = tonumber(args.num1)
              local num2 = tonumber(args.num2)
              local operation = args.operation

              if not num1 then
                return { status = "error", data = "First number is missing or invalid" }
              end

              if not num2 then
                return { status = "error", data = "Second number is missing or invalid" }
              end

              if not operation then
                return { status = "error", data = "Operation is missing" }
              end

              local result
              if operation == "add" then
                result = num1 + num2
              elseif operation == "subtract" then
                result = num1 - num2
              elseif operation == "multiply" then
                result = num1 * num2
              elseif operation == "divide" then
                if num2 == 0 then
                  return { status = "error", data = "Cannot divide by zero" }
                end
                result = num1 / num2
              else
                return {
                  status = "error",
                  data = "Invalid operation: must be add, subtract, multiply, or divide",
                }
              end

              return { status = "success", data = result }
            end
          '';
        };
        system_prompt = ''
          ## Calculator Tool (`calculator`)

          ## CONTEXT
          - You have access to a calculator tool running within CodeCompanion, in Neovim.
          - You can use it to add, subtract, multiply or divide two numbers.

          ### OBJECTIVE
          - Do a mathematical operation on two numbers when the user asks

          ### RESPONSE
          - Always use the structure above for consistency.
        '';
        schema = {
          type = "function";
          function = {
            name = "calculator";
            description = "Perform simple mathematical operations on a user's machine";
            parameters = {
              type = "object";
              properties = {
                num1 = {
                  type = "integer";
                  description = "The first number in the calculation";
                };
                num2 = {
                  type = "integer";
                  description = "The second number in the calculation";
                };
                operation = {
                  type = "string";
                  enum = [
                    "add"
                    "subtract"
                    "multiply"
                    "divide"
                  ];
                  description = "The mathematical operation to perform on the two numbers";
                };
              };
              required = [
                "num1"
                "num2"
                "operation"
              ];
              additionalProperties = false;
            };
            strict = true;
          };
        };
        handlers = {
          setup.__raw = ''
            function(self,agent)
              return vim.notify("setup function called", vim.log.levels.INFO)
            end
          '';
          on_exit.__raw = ''
            function(self, agent)
              return vim.notify("on_exit function called", vim.log.levels.INFO)
            end
          '';
        };
        output = {
          success.__raw = ''
            function(self, agent, cmd, stdout)
              local chat = agent.chat
              return chat:add_tool_output(self, tostring(stdout[1]))
            end
          '';
          error.__raw = ''
            function(self, agent, cmd, stderr, stdout)
              return vim.notify("An error occurred", vim.log.levels.ERROR)
            end
          '';
        };
      };
      notes = {
        description = "Create note";
        callback = {
          name = "notes";
          cmds = {
            __unkeyed.__raw = ''
              function(self, args, input)
                local type = tonumber(args.type)
                local text = tonumber(args.text)

                if not type then
                  return { status = "error", data = "Note type is missing" }
                end

                if not num2 then
                  return { status = "error", data = "Text is missing" }
                end

                local result
                if type == "asset" then
                  result = num1 + num2
                elseif operation == "task" then
                  result = num1 - num2
                else
                  return {
                    status = "error",
                    data = "Invalid type: must be asset or task",
                  }
                end

                return { status = "success", data = result }
              end
            '';
          };
          system_prompt = ''
            ## Notes Tool (`notes`)

            ## CONTEXT
            - You have access to a notes tool running within CodeCompanion, in Neovim.
            - You can use it to create notes using zk tools.

            ### OBJECTIVE
            - Do a mathematical operation on two numbers when the user asks

            ### RESPONSE
            - Always use the structure above for consistency.
          '';
          schema = {
            type = "function";
            function = {
              name = "calculator";
              description = "Perform simple mathematical operations on a user's machine";
              parameters = {
                type = "object";
                properties = {
                  num1 = {
                    type = "integer";
                    description = "The first number in the calculation";
                  };
                  num2 = {
                    type = "integer";
                    description = "The second number in the calculation";
                  };
                  operation = {
                    type = "string";
                    enum = [
                      "add"
                      "subtract"
                      "multiply"
                      "divide"
                    ];
                    description = "The mathematical operation to perform on the two numbers";
                  };
                };
                required = [
                  "num1"
                  "num2"
                  "operation"
                ];
                additionalProperties = false;
              };
              strict = true;
            };
          };
          handlers = {
            setup.__raw = ''
              function(self,agent)
                return vim.notify("setup function called", vim.log.levels.INFO)
              end
            '';
            on_exit.__raw = ''
              function(self, agent)
                return vim.notify("on_exit function called", vim.log.levels.INFO)
              end
            '';
          };
          output = {
            success.__raw = ''
              function(self, agent, cmd, stdout)
                local chat = agent.chat
                return chat:add_tool_output(self, tostring(stdout[1]))
              end
            '';
            error.__raw = ''
              function(self, agent, cmd, stderr, stdout)
                return vim.notify("An error occurred", vim.log.levels.ERROR)
              end
            '';
          };
        };
      };
    };
  };
}
