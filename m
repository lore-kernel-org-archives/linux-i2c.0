From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] i2c: align i2c_device_id
Date: Mon, 19 May 2008 21:20:19 +0200
Message-ID: <4831D2F3.6020506@gmail.com>
References: <1211203124-3096-1-git-send-email-jirislaby@gmail.com> <20080519210003.65b65d14@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759345AbYESTVY@vger.kernel.org>
In-Reply-To: <20080519210003.65b65d14@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 05/19/2008 09:00 PM, Jean Delvare wrote:
> Hi Jiri,

Hi.

> Thanks for this patch, it's in my i2c tree now and will be sent to
> Linus by the end of the week. I wasn't aware of this possible alignment
> issue, sorry.

To be honest, neither I was until I hit it while testing hid bus (where I did 
the same mistake). Thanks.
