local M = {}

function M.register()
  local ls = require 'luasnip'

  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node

  ls.add_snippets('python', {
    s('ppyt', {
      t {
        '@pytest.mark.unit',
        '@pytest.mark.parametrize(',
        '    "',
      },
      i(1, 'config_dir'),
      t {
        '",',
        '    [',
        '        pytest.param("config/sandbox/rel1977_1", id="sandbox_actual"),',
        '    ],',
        ')',
        'def ',
      },
      i(2, 'test_app_vpc_stack'),
      t {
        '(request, config_dir, update_golden):',
        '    """test app_vpc_stack"""',
        '',
        '    case = Case(request)',
        '    s_input = AppVpcInput.from_config_directory(',
        '        Case.abs_path_from_project_root(config_dir)',
        '    )',
        '',
        '    app = App()',
        '',
        '    stk = AppVpcStack(',
        '        scope=app,',
        '        construct_id=f"{s_input.app_vpc.construct_id_prefix}Stack",',
        '        cdk_env=Environment(),',
        '        s_input=s_input,',
        '    )',
        '    template = assertions.Template.from_stack(stk)',
        '    if update_golden:',
        '        case.update_expected(template.to_json))',
        '',
        '    template.template_matches(case.expected())',
      },
    }),
  })
end

return M