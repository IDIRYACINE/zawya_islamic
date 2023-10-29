insert into schools 
VALUES(
    '1bc6e619-d645-4463-88af-df9356d60bc0',
    'مدرسة الامام الشافعي'
);

insert into groups VALUES
(
    '9da74926-4538-4b38-af8b-9d07e75cd630',
    'الثاني',
    '1bc6e619-d645-4463-88af-df9356d60bc0'
)


insert into
    users
VALUES
(
        'd669c5f8-746e-4291-b462-b304e775a896',
        'امير مشري',
        2,
        '2023-10-17',
        '1bc6e619-d645-4463-88af-df9356d60bc0'
    );

insert into 'userGroups' 
Values(
    'd669c5f8-746e-4291-b462-b304e775a896',
    '9da74926-4538-4b38-af8b-9d07e75cd630'
);