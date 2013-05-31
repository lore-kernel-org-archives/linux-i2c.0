From: CF <cfoissac-GANU6spQydw@public.gmane.org>
Subject: Newbie: accessing i2c features through kernel functions
Date: Fri, 31 May 2013 11:49:41 +0200
Message-ID: <51A87235.2060702@free.fr>
References: <1369818463.42609.YahooMailNeo@web141202.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369818463.42609.YahooMailNeo-KCWTPBDN160R8UyDmTZ/NZEhsgyP+Z75VpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

I'm requesting help. I am currently successfully using i2c-dev module.
But i'm unable to drive i2c busses from kernel space as i'd do from
userspace (with the use of open, read, write, ioctl functions). I can't
logically acces glibc.

Can somebody point me how i could do from kernel space ? Given all is
actually working (precisely, i can recompile i2c-dev, and i write an
userspace code to manage my i2c slave device).

My goal is to keep i2c-dev suitable initialisation, then wrap some i2c
commands into the module to expose userspace a simplified API, with all
my device commands. I must do this in kernel space, else i'd have done
what i'm able to do: create an userspace lib relying on /dev/i2c-x.

Thank you. Once again i apologize if this is not the place but i'm
unable to find suitable ML for this kind of request.
