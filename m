From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix Kconfig dependencies
Date: Tue, 05 Oct 2010 00:01:02 +0200
Message-ID: <4CAA4E9E.8040002@suse.cz>
References: <1286199093-3576-1-git-send-email-mmarek@suse.cz> <20101004180346.59b10af7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101004180346.59b10af7-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4.10.2010 18:03, Jean Delvare wrote:
> You have bad luck, I'm afraid. Sure, most users do not unset
> I2C_HELPER_AUTO, so they will not see the extra entries in the main I2C
> menu, however _I_ unset it and guess what, _I_ am the one deciding
> whether your patch can be applied or not ;)

OK :).


>> Please consider for 2.6.36, as the warning is caused by a kconfig fix
>> that I'm about to send to Linus for 2.6.36. And it is triggered by a
>> simple 'make defconfig' in i386/x84_64:
> 
> You should reconsider then. Kernel 2.6.36 will be released in a few
> days, is your fix so important that it has to go in, even when you have
> evidence that it breaks other parts of the configuration, which in turn
> will have to be fixed?

To clarify: The kconfig fix does not "break" anything. It just correctly
warns in cases where it previously did not spot a broken dependency. My
patch was just a means to silence a warning, nothing more.

Michal
