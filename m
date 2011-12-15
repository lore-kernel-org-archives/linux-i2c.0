From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Cleanly intercepting suspend/resume of specific i2c clients?
Date: Wed, 14 Dec 2011 23:35:34 -0600
Message-ID: <CADkCAuteSObrXMnmN--8AG84-V_aWWudt_EXwBNPZfG6GHG2hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guys:


I need to catch the suspend and resume events sent to specific i2c
clients, so that I can do platform-specific reconfigurations after the
target client has been suspended/before the target client is resumed.
These reconfigurations include GPIO tweaks that I don't want to appear
in the driver for the i2c client, due to their being highly
platform-specific.

I routinely deal with this for platform devices by registering a
parent device that knows the platform-specific details surrounding the
chip.  There doesn't appear to be a clean way to do something similar
for i2c devices, unfortunately, because each i2c device is forcibly
designated as a child of its adapter device during i2c_new_device().
And after thinking about this problem for a couple of days, I don't
see a clear path forward on this.  (I do understand why parenting is
done the way it is in i2c, though).

For example, I considered implementing a platform device that would
call i2c_new_device() in its probe() method.  But then the new client
is parented by its i2c-adapter, so that platform device would never
get the suspend/resume callbacks.

Another idea was to implement a platform-specific i2c client driver,
which would call i2c_new_device() for the generic driver in its
probe().  But this still has the same problem of incorrect parentage.

I don't want some sort of callback via function passed in the i2c
client's platform data, however, because that discloses the need for
such callbacks at the right times during suspend/resume.  Those "right
times" have proven problematic to get correct in previous attempts, in
particular when I must wait for two or three i2c clients to be
suspended before I can do any of the platform-specific cleanups.  It
also hides the necessity for additional work on the part of the kernel
each time the device is suspended/resumed, preventing me taking
advantage of the ordinary parent-child suspend ordering that Linux can
do for me today.  Finally, I would rather the i2c client drivers
remain pristine.

What I'm kind of settling on now is parenting the i2c-adapter devices,
which in my case are all platform devices.  But then I don't really
get per-client callbacks, and I'm not sure that my runtime PM
callbacks will be optimal.  This approach conforms to the existing
device model APIs, but doesn't really get me everything I want.

Something else I'm considering is mucking around in the dev.parent
reference for the i2c client device after it is registered.  But man,
that seems really, really inelegant even though device_move() appears
to be designed specifically for such purposes.  It just seems
overkill, and I also wonder if suspend/resume will still work properly
on i2c after I get done reparenting everything.

Finally, I'm considering just brute-force changing the i2c client's
suspend/resume function pointers after the client is registered, but
this causes problems if there are multiple devices of the same type in
the system.  I can deal with this by inspecting the client's address
and other information during the suspend, however (I would call the
chip's own suspend/resume methods inside the interceptor functions).
This idea is my most temping one, actually.

Anyone have any better suggestions here?  I'm really not seeing
anything I like, but I can't believe I'm the first person to have to
deal with this.  I'm hoping I'm just not seeing something obvious...

Thanks!


b.g.
-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org
