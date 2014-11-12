From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create "channel-n" symlinks for child segments
Date: Wed, 12 Nov 2014 06:15:10 -0800
Message-ID: <CAAVjN7eG1D2fmu0gBqR8bwuo1i6e0XWju02JwVaO45YAr5qNkA@mail.gmail.com>
References: <1415363764-10821-1-git-send-email-wsa@the-dreams.de>
	<CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ@mail.gmail.com>
	<20141108175117.GB4900@katana>
	<CAAVjN7fJ0d2-Rp_9poPxMbrCVmz9be7-yZCE-Z7Vr=E4L8rpAg@mail.gmail.com>
	<20141112124231.GA1289@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141112124231.GA1289@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Well the patch works (and is cleaner and uses slightly less resources
and is how it should have been done originally)...but it breaks my
current API (the path parsing will need to be modified) (parsing the
parent device name (old fromat "i2c-%d" new "i2c-%d/%d-%04x" id to
determine the parent adapter id). I can modify lsi2c to work with this
new API, and it shouldn't be too difficult. But I cant update the tool
until this is committed.

OLD:

lrwxrwxrwx 1 admin root 0 Nov 12 06:01 i2c-15 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/i2c-15
lrwxrwxrwx 1 admin root 0 Nov 12 06:01 i2c-16 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/i2c-16
lrwxrwxrwx 1 admin root 0 Nov 12 06:01 i2c-17 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/i2c-17

NEW:

lrwxrwxrwx 1 root root 0 Nov 12 05:50 i2c-15 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/1-0074/i2c-15
lrwxrwxrwx 1 root root 0 Nov 12 05:50 i2c-16 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/1-0074/i2c-16
lrwxrwxrwx 1 root root 0 Nov 12 05:50 i2c-17 ->
../../../devices/soc.0/ffe03100.i2c/i2c-1/1-0074/i2c-17

On Wed, Nov 12, 2014 at 4:42 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Wed, Nov 12, 2014 at 04:29:13AM -0800, Danielle Costantino wrote:
>> Could you send an aggregated patch, I want to be sure I test exactly
>> what is planned in the final patch (the patch says it includes part of
>> the next patch "[PATCH v2] i2c: mux: create proper topology in sysfs".
>
> ? V2 *is* the final patch :) https://patchwork.ozlabs.org/patch/408381/



-- 
- Danielle Costantino
