From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH 1/1] i2c: align i2c_device_id
Date: Mon, 19 May 2008 21:25:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0805192105470.6129@shell4.speakeasy.net>
References: <1211203124-3096-1-git-send-email-jirislaby@gmail.com>
 <20080519210003.65b65d14@hyperion.delvare> <4831D2F3.6020506@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759367AbYETEZT@vger.kernel.org>
In-Reply-To: <4831D2F3.6020506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 19 May 2008, Jiri Slaby wrote:
> On 05/19/2008 09:00 PM, Jean Delvare wrote:
> > Thanks for this patch, it's in my i2c tree now and will be sent to
> > Linus by the end of the week. I wasn't aware of this possible alignment
> > issue, sorry.
>
> To be honest, neither I was until I hit it while testing hid bus (where I did
> the same mistake). Thanks.

Is there any more information about this?  Items in a structure should be
aligned to the alignment required by their type.  Usually sizeof(x) ==
alignof(x), but not always.

I guess in this case the structures are used as a cross-platform binary on
disk representation, and so the alignment of the build host must match the
alignment of the target?

Maybe it would be better to include the alignment attribute in the
definition of kernel_ulong_t?
