From: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-tools: NULL in i2c-dev.h
Date: Sun, 2 Jun 2013 20:30:27 +0200
Message-ID: <CAOE8yMCB-96oVYH0HqKW7nTc3rPvJJVyxxbxmY9BRjv7wxdSmA@mail.gmail.com>
References: <CAOE8yMAkZmNmGpB7ERKYuz5smjX2MNryf4hqvxyr892kwx1bSg@mail.gmail.com>
Reply-To: mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOE8yMAkZmNmGpB7ERKYuz5smjX2MNryf4hqvxyr892kwx1bSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Sun, Jun 2, 2013 at 8:01 PM, Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I was trying to write a CMake check for i2c-dev.h.
> This did not work, because "NULL" is used in i2c-dev.h, but NULL is not
> defined, during the check.

CMake can include more headers in the check:

>CHECK_STRUCT_MEMBER(i2c_msg buf  "string.h;${INC_I2C_DEV_H}/i2c-dev.h"    HAS_I2C_MSG)

With this string.h defines NULL, problem solved.

regards,

Martin
