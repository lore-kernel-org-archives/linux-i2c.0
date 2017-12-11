From: Alban Browaeys <alban.browaeys@gmail.com>
Subject: Re: [PATCH] i2c: i801: Fix SMBus ENXIO on resume from suspend.
Date: Mon, 11 Dec 2017 12:45:22 +0100
Message-ID: <1512992722.29040.2.camel@gmail.com>
References: <20171115170156.21532-1-alban.browaeys@gmail.com>
         <1510777525.21208.4.camel@gmail.com> <20171120101514.62239b4f@endymion>
         <f43a23f8-31e1-8498-c3e9-cfd1ec425150@t-online.de>
         <20171121124928.63c271a2@endymion>
         <20171207105745.zg4bbhdf66gxh4m2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36450 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLKLp0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 06:45:26 -0500
Received: by mail-wr0-f180.google.com with SMTP id v105so17237084wrc.3
        for <linux-i2c@vger.kernel.org>; Mon, 11 Dec 2017 03:45:25 -0800 (PST)
In-Reply-To: <20171207105745.zg4bbhdf66gxh4m2@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc: Volker =?ISO-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>, linux-i2c@vger.kernel.org

Le jeudi 07 décembre 2017 à 11:57 +0100, Wolfram Sang a écrit :
> > > > Volker, I think you had a fix for that one? But I can't find it
> > > > in the
> > > > list archive :-(
> > > 
> > > Yes, on 13 Jun 2017 I sent a patch to the linux-i2c mailing list.
> > > But
> > > the mailing list server told me: Your address is not liked source
> > > for
> > > email. At this point I gave up.
> > 
> > I see, that's why it's in my mailbox but missing from the archive.
> >  
> > > If you are still interested I can try to resend the patch with my
> > > google email account.
> > 
> > I'll review it, so it will become visible :-)
> 
> So, Volker's patch showed up on the ML meanwhile, nice :)
> 
> I don't get if we need this patch as well or if this gets covered
> with
> Volker's patch as well?

Mine is a rough duplicate of Volker.

But it turns out none of those take care of the ENXIO issue. I thought
otherwise at first but this bug is not easely reproducible except on
cold boot.
I am at loss as to how to fix my ENXIO issue.

Thanks,
Alban
