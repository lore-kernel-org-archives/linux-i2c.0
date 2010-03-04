From: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-i801: All newer devices have all the optional
 features
Date: Thu, 4 Mar 2010 13:56:40 -0800
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF254B5D623A@orsmsx501.amr.corp.intel.com>
References: <20100304115404.092b8183@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100304115404.092b8183-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>Only the oldest devices lack some of the features supported by this
>driver. List them explicitly, and default to all features enabled for
>all other chips, including the ones added through sysfs. This will
>make future driver maintenance easier.
>
>In the unlikely event of a not yet supported device not implementing
>all the features, one can always use the disable_features module
>parameter to prevent the driver from attempting to use them.
>
>Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>---
>Seth, what do you think? Does it make sense to you?

Makes perfect sense to me. 

-Seth
