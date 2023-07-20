insert into
    public."userRoles"
values
    (0, 'admin'),
    (1, 'teacher'),
    (2, 'student'),
    (3, 'anonymous');

insert into
    public.users
values
    (
        'ba3a942a-37a9-404b-a95e-da289fb901f1',
        'idiryacine',
        0,
        null
    );    

insert into
    auth.users (
        instance_id,
        id,
        aud,
        role,
        email,
        encrypted_password,
        email_confirmed_at,
        invited_at,
        confirmation_token,
        confirmation_sent_at,
        recovery_token,
        recovery_sent_at,
        email_change_token_new,
        email_change,
        email_change_sent_at,
        last_sign_in_at,
        raw_app_meta_data,
        raw_user_meta_data,
        is_super_admin,
        created_at,
        updated_at,
        phone,
        phone_confirmed_at,
        phone_change,
        phone_change_token,
        phone_change_sent_at,
        email_change_token_current,
        email_change_confirm_status,
        banned_until,
        reauthentication_token,
        reauthentication_sent_at
    )
values
    (
        '00000000-0000-0000-0000-000000000000',
        'ba3a942a-37a9-404b-a95e-da289fb901f1',
        'authenticated',
        'authenticated',
        'idiryacinesp@gmail.com',
        crypt('idiryacine', gen_salt('bf')),
        '2023-01-11 16:54:12.7991+00',
        NULL,
        '',
        NULL,
        '',
        NULL,
        '',
        '',
        NULL,
        '2023-01-11 16:54:12.801124+00',
        '{"provider": "email", "providers": ["email"]}',
        '{}',
        NULL,
        '2023-01-11 16:54:12.796822+00',
        '2023-01-11 16:54:12.80197+00',
        NULL,
        NULL,
        '',
        '',
        NULL,
        '',
        0,
        NULL,
        '',
        NULL
    );