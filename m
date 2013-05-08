From: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c multimaster and the device driver detect function
Date: Wed, 8 May 2013 11:57:59 -0400
Message-ID: <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
References: <20130212164811.GV8668@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130212164811.GV8668-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I've read the discussion on multimaster and I have to agree with Uwe about masters doing the arbitration (and retry). However, there's another issue which one quickly discovers when adding a second master on a physical i2c bus.

Here's the scenario: Using driver jc42 which adds a "detect" function, and using two masters which end-up creating "i2c-0" and "i2c-1", the temp sensors get instanciated twice, i.e. once on each bus master. This is obviously very problematic as there are two driver instances controlling the exact same chip.

Before I dive a bit too much into this, is there something I am missing?

Should there be a "struct i2c_bus" along side "struct i2c_adapter" where the adapter would point to an i2c_bus or something? Sounds like this would have many downstream implications, and until today, I've only written device drivers not core. I could try something, but due diligence dictates i2c maintainers should provide input before I get lost into un-mergeable work.

Thanks for your input!
