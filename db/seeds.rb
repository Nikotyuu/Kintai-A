# coding: utf-8

User.create!(name: "明日香　キララ",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             employee_number: "64",
             admin: true)

User.create!(name: "ドラゴン",
             email: "sampleA@email.com",
             password: "password",
             password_confirmation: "password",
             employee_number: "21",
             superior: true)
             
User.create!(name: "ファルコ",
             email: "sampleB@email.com",
             password: "password",
             password_confirmation: "password",
             employee_number: "7",
             superior: true)

User.create!(name: "マーカス",
             email: "sample1@email.com",
             password: "password",
             password_confirmation: "password",
             employee_number: "18"
             )