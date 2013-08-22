From: James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: pxa: enable high speed mode for i2c bus
Date: Thu, 22 Aug 2013 10:02:30 +0800
Message-ID: <CAOng1WQCiPHzM7kCGpK=taY2mv+eGBgEUWpnauwfMsd2AXs82A@mail.gmail.com>
References: <1376016204-31328-1-git-send-email-shangll@marvell.com>
	<CAOng1WTAemGWLVw0naPyDt4kjvu5N0mx9vucytrj2Cr7X_46VQ@mail.gmail.com>
	<20130815123915.GE17155@katana>
	<CAOng1WTiWCaF_LNtRnK4MsCF77pf9J689FaFf-sZ4ZJ9mj+oYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOng1WTiWCaF_LNtRnK4MsCF77pf9J689FaFf-sZ4ZJ9mj+oYw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Did I misunderstand something?

Best regards,
Leilei

2013/8/16 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Wolfram,
>
> Thanks for your quick response!
>
> Do you mean my initial patch has already been accept and I don't need
> to push patch v2?
> If yes, do I need to rebase the patch?
>
> And sorry for don't write changelog.
>
> Best regards,
> Leilei
>
> 2013/8/15 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>> On Thu, Aug 15, 2013 at 06:48:28PM +0800, James Lebron wrote:
>>> Hi Guys
>>>
>>> Any comments?
>>
>> As I wrote on August, 7th, I accepted the last version already; it is
>> also in linux-next since then. So, this series is not needed if the only
>> thing changed was the addition of the PXA910 register set. Since you
>> didn't write a changelog (please always do) I assume there are no
>> further changes.
>>
