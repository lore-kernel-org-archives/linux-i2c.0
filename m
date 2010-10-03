From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [lm-sensors] [RFC PATCH 2/9] hwmon: lis3: regulator control
Date: Sun, 03 Oct 2010 12:21:17 +0100
Message-ID: <4CA8672D.2070801@cam.ac.uk>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>	 <1285933616-16044-3-git-send-email-samu.p.onkalo@nokia.com>	 <4CA76CDA.4040803@cam.ac.uk> <1286083558.2064.35.camel@noppispoppis.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286083558.2064.35.camel-Vo7XL3ix0D0UEupzmRo7jhl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org" <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


...
>> subtle change here... Out of intererst, why did the top level lis3_dev
>> structure ever exist?  (you can tell I haven't looked closely at this driver
>> before!) Can remove_fs return an error? 
> 
> Remove fs returns always 0. 
> 
> There are couple of bigger changes which somebody should do to this
> driver:
> - Change static lis3_dev structure to a dynamically allocated one//generalize
Definitely.
> - Add proper error handling to the driver.

Agreed, hopefully someone will step up and do it (good job for a starting out
kernel dev perhaps?)
