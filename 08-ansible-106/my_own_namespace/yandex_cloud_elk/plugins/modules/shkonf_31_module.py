#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
from ansible.module_utils.basic import AnsibleModule


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    result = dict(
        changed=False,
        path='',
        message=''
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    result['message'] = 'Nothing to do'
    result['path'] = module.params['path']

    if os.path.exists(module.params['path']):
        try:
            with open(module.params['path'], 'r') as f:
                current_content = f.read()

            if current_content != module.params['content']:
                result['changed'] = True
                result['message'] = 'File updated'
        except Exception as e:
            module.fail_json(msg=f"Failed to read file '{module.params['path']}': {str(e)}", **result)
    else:
        result['changed'] = True
        result['message'] = 'File created'

    if module.check_mode:
        result['message'] = 'Check mode: ' + result['message']
        module.exit_json(**result)

    if result['changed']:
        try:
            with open(module.params['path'], 'w') as f:
                f.write(module.params['content'])
        except Exception as e:
            module.fail_json(msg=f"Failed to write data to '{module.params['path']}': {str(e)}", **result)

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()