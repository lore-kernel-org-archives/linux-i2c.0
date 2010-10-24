From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: Re: [PATCH 00/12] lis3 accelerator feature update
Date: Sun, 24 Oct 2010 17:05:33 +0200
Message-ID: <4CC44B3D.5030404@tremplin-utc.net>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Op 22-10-10 13:57, Samu Onkalo schreef:
> Changes are tested only with I2C interface using 8bit sensor since I don't
> have other possibilities. Some features are not enabled
> by default since I can't test them with all possible configurations.
> Platform data contains field which controls new features.
Thanks Samu for persevering with the automatic power down feature. 
Hopefully I'll find also some time to activate it on the hp_accel side.

For now, I've reviewed the changes and everything looked fine, as well 
as tested them on my HP laptop (with a 12 bits sensor). Although most of 
the changes are not visible on this platform, at least there shouldn't 
be any regression.

Thanks,
Eric
