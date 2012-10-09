From: Maxin B John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: busses: i2c-ocores: switch to devm_request_and_ioremap
Date: Tue, 9 Oct 2012 05:13:13 -0400
Message-ID: <CAMhs6YztTFh0fQFfJOwc++fr-xXxEJU5KvcSvOcAcyyDgWOBDQ@mail.gmail.com>
References: <20120923133358.GA22861@linux-3ix0.site>
	<874nmoa9b1.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874nmoa9b1.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Sun, Sep 23, 2012 at 2:22 PM, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org> wrote:
>>>>>> "Maxin" == Maxin B John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>
>  Maxin> This drops a few lines of code and allows common APIs to handle
>  Maxin> those for us.
>
>  Maxin> Signed-off-by: Maxin B. John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

Is there any update on this ?

> --
> Bye, Peter Korsgaard

Best Regards,
Maxin B. John
