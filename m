From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: RFC: proposal for new i2c.h macro to initialize i2c address lists on the fly
Date: Sat, 6 Jun 2009 15:00:48 +0200
Message-ID: <200906061500.49338.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

For video4linux we sometimes need to probe for a single i2c address. 
Normally you would do it like this:

static const unsigned short addrs[] = {
	addr, I2C_CLIENT_END
};

client = i2c_new_probed_device(adapter, &info, addrs);

This is a bit awkward and I came up with this macro:

#define V4L2_I2C_ADDRS(addr, addrs...) \
        ((const unsigned short []){ addr, ## addrs, I2C_CLIENT_END })

This can construct a list of one or more i2c addresses on the fly. But this 
is something that really belongs in i2c.h, renamed to I2C_ADDRS.

With this macro we can just do:

client = i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr));

Comments?

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
