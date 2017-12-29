From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] eeprom: at24: check the return value of
 nvmem_unregister()
Date: Fri, 29 Dec 2017 10:48:47 +0100
Message-ID: <20171229094847.GC16993@localhost>
References: <20171227141038.31646-1-brgl@bgdev.pl>
 <20171228112845.GB3729@localhost>
 <CAMRc=MfQvQ+PEcQZRcs8baHPgyrXQ_=m6YXCtbqDseYHMGOZtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38285 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754949AbdL2Jsv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Dec 2017 04:48:51 -0500
Content-Disposition: inline
In-Reply-To: <CAMRc=MfQvQ+PEcQZRcs8baHPgyrXQ_=m6YXCtbqDseYHMGOZtw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Johan Hovold <johan@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Thu, Dec 28, 2017 at 10:42:21PM +0100, Bartosz Golaszewski wrote:
> 2017-12-28 12:28 GMT+01:00 Johan Hovold <johan@kernel.org>:
> > On Wed, Dec 27, 2017 at 03:10:38PM +0100, Bartosz Golaszewski wrote:
> >> This function can fail with -EBUSY, but we don't check its return
> >> value in at24_remove(). Bail-out of remove() if nvmem_unregister()
> >> doesn't succeed.
> >>
> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >> ---
> >>  drivers/misc/eeprom/at24.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> >> index e79833d62284..fb21e1c45115 100644
> >> --- a/drivers/misc/eeprom/at24.c
> >> +++ b/drivers/misc/eeprom/at24.c
> >> @@ -684,11 +684,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >>  static int at24_remove(struct i2c_client *client)
> >>  {
> >>       struct at24_data *at24;
> >> -     int i;
> >> +     int i, ret;
> >>
> >>       at24 = i2c_get_clientdata(client);
> >>
> >> -     nvmem_unregister(at24->nvmem);
> >> +     ret = nvmem_unregister(at24->nvmem);
> >> +     if (ret)
> >> +             return ret;
> >
> > I don't this makes much sense as a driver cannot refuse an unbind by
> > returning an errno from remove(). The return value is simply ignored,
> > remove() will never be called again, and you'd leave everything in an
> > inconsistent state.
> >
> 
> Cc: Srinivas
> 
> Hi Johan,
> 
> I blindly assumed that if there's a return value in remove() then
> someone cares about it. In that case all users of nvmem_unregister()
> that check the return value and bail-out of remove() on failure are
> wrong and in the (very unlikely) event that this routine fails, we
> leak all resources.

I see only one other driver that bails out on deregistration errors
(lpc18xx_eeprom.c), even if other drivers do indeed propagate errors.

> > It looks like the nvmem code grabs a reference to the owning module
> > in __nvmem_device_get() which would at least prevent a module unload
> > while another driver is using the device. And the (sysfs) userspace
> > interface should be fine as device removal is handled by the kernfs
> > code.
> 
> Indeed. I believe we should remove the -EBUSY return case from
> nvmem_register() and just do what gpiolib does - scream loud
> (dev_crit()) when someone forces a module unload or otherwise
> unregisters the device if some cells are still requested. This would
> also allow us to eventually add a devres variant for nvmem_register().

I really don't like using devres for deregistration since typically
you'd need a follow-on deallocation step or you end up with a weird
asymmetric interface, but that's another story.

And again, the module unload case would not be a problem, at least when
the device is looked up from device tree, as nvmem then grabs a module
reference.

Johan
