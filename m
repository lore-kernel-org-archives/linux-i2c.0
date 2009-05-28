From: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
 by  read i2c_msg
Date: Thu, 28 May 2009 23:22:52 +0200
Message-ID: <4A1F00AC.3060403@doredevelopment.dk>
References: <4A124202.4010201@doredevelopment.dk>	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>	<20090526213351.GG23114@fluff.org.uk>	<20090528171726.GE3112@pengutronix.de>	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>	<87ws8155md.fsf@macbook.be.48ers.dk>	<d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com> <87octd5415.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87octd5415.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "Esben" == Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>             
>
> Hi,
>
>  Esben> It's strange, that line looks perfectly fine when I check the
>  Esben> mail in my GMail inbox and the outbox from the account I sent
>  Esben> it from.
>
> Well, it is here and in the archive:
> http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072274.html
>   
If you look at
http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg01050.html
instead, the patch is not broken.  I find it more likely that the ozlabs.org
archive is breaking my lines, than mail-archive.com putting broken lines
together again.
> Please consider using git send-email for patches.
>   
I used git imap-send and thunderbird to do it.

I will consider git send-email in the future, although I don't think
my original e-mail were broken ;-)

But
