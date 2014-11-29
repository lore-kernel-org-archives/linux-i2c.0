From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: mux: create "channel-n" symlinks for child
 segments in the mux device
Date: Sat, 29 Nov 2014 15:29:46 -0800
Message-ID: <CAAVjN7etzqy7tum5yboVErhWZ=VhKy9c6UG5xMMTihgjG9ZDqg@mail.gmail.com>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de>
	<1415885996-14770-2-git-send-email-wsa@the-dreams.de>
	<20141118151204.GD30004@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141118151204.GD30004@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I know this has already been applied but I wanted to comment that on
embedded systems this patch increases the probe time of mux devices.
Otherwise the patch works and provides much needed parent device
information without breaking the api.

On Tue, Nov 18, 2014 at 7:12 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Nov 13, 2014 at 02:39:56PM +0100, Wolfram Sang wrote:
>> From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>>
>> This makes the topology clearer. For instance, by adding a pca9547
>> device with address 0x70 to bus i2c-0, you get:
>>
>> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-0 -> i2c-1
>> ...
>> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-7 -> i2c-8
>>
>> Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>> [wsa: simplified sysfs-usage and fixed format string usage]
>> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
>> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
>> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
>> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
>
> Applied to for-next, thanks!
>



-- 
- Danielle Costantino
