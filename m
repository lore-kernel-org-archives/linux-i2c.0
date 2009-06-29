From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Mon, 29 Jun 2009 12:57:04 +0200
Message-ID: <20090629105704.GA1478@ucw.cz>
References: <4A448926.1030701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A448926.1030701-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri 2009-06-26 17:39:02, Minkyu Kang wrote:
> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> This patch adds support the GP2A002 sensor
> 
> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Suchang Woo <suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

It would be nice to document what it does and what interface to
userland it provides...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
