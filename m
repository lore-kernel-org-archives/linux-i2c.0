From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 0/11] introduce macros for i2c_msg initialization
Date: Mon, 22 Oct 2012 11:18:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1210221059100.2026@hadrien>
References: <1349624323-15584-1-git-send-email-Julia.Lawall@lip6.fr> <20121009173237.7c1a49e9@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121009173237.7c1a49e9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I have been looking at this again, with the macros

#define I2C_MSG_OP(_addr, _buf, _len, _flags) \
        { .addr = _addr, .buf = _buf, .len = _len, .flags = _flags }

#define I2C_MSG_WRITE(addr, buf, len) \
        I2C_MSG_OP(addr, buf, len, 0)
#define I2C_MSG_READ(addr, buf, len) \
        I2C_MSG_OP(addr, buf, len, I2C_M_RD)
#define I2C_MSG_WRITE_OP(addr, buf, len, op) \
        I2C_MSG_OP(addr, buf, len, 0 | op)
#define I2C_MSG_READ_OP(addr, buf, len, op) \
        I2C_MSG_OP(addr, buf, len, I2C_M_RD | op)

and the tuners files as a random first example.  This time I haven't made
any adjustments for arrays of size 1.

The following file is a bit unfortunate, because a single structure is
mostly used for writing, but sometimes used for reading, in the function
tda827xa_set_params.  That is, there are explicit assignments to
msg.flags.

drivers/media/tuners/tda827x.c

Currently, this is done in 8 files across the entire kernel.  Would it be
a problem to use a READ or WRITE macro to initialize such a structure,
give that the type is going to change?  Maybe the I2C_MSG_OP macro could
be used, with an explicit flag argument?

julia
