From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create "channel-n" symlinks for child segments
Date: Wed, 12 Nov 2014 04:29:13 -0800
Message-ID: <CAAVjN7fJ0d2-Rp_9poPxMbrCVmz9be7-yZCE-Z7Vr=E4L8rpAg@mail.gmail.com>
References: <1415363764-10821-1-git-send-email-wsa@the-dreams.de>
	<CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ@mail.gmail.com>
	<20141108175117.GB4900@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141108175117.GB4900@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Could you send an aggregated patch, I want to be sure I test exactly
what is planned in the final patch (the patch says it includes part of
the next patch "[PATCH v2] i2c: mux: create proper topology in sysfs".

On Sat, Nov 8, 2014 at 9:51 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Fri, Nov 07, 2014 at 11:47:37PM -0800, Danielle Costantino wrote:
>> Just tested it and it work well for me. lsi2c (a tool I have been
>> developing) was complacently unaffected, I will be releasing it as an
>> open source app soon.
>
> Thanks, can you check this patch ("[PATCH v2] i2c: mux: create proper
> topology in sysfs"), too? I sent it out a second ago.
>



-- 
- Danielle Costantino
