From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using (i2c) drivers
Date: Thu, 16 Dec 2010 00:39:24 +0100
Message-ID: <201012160039.24552.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1012151530590.2171-100000@iolanthe.rowland.org> <201012152301.18700.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012152301.18700.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday, December 15, 2010, Rafael J. Wysocki wrote:
> On Wednesday, December 15, 2010, Alan Stern wrote:
> > On Wed, 15 Dec 2010, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > > Subject: PM / Runtime: Fix pm_runtime_suspended()
> > > 
> > > pm_runtime_suspended() shouldn't return true if the runtime PM of the
> > > given device is disabled.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > > ---
> > >  include/linux/pm_runtime.h |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/include/linux/pm_runtime.h
> > > ===================================================================
> > > --- linux-2.6.orig/include/linux/pm_runtime.h
> > > +++ linux-2.6/include/linux/pm_runtime.h
> > > @@ -78,7 +78,8 @@ static inline void device_set_run_wake(s
> > >  
> > >  static inline bool pm_runtime_suspended(struct device *dev)
> > >  {
> > > -	return dev->power.runtime_status == RPM_SUSPENDED;
> > > +	return dev->power.runtime_status == RPM_SUSPENDED
> > > +		&& !dev->power.disable_depth;
> > >  }
> > 
> > You need to update the documentation entry for pm_runtime_suspended as 
> > well.
> 
> Yes, I also need to rework the changelog to explain what exactly the problem is.

Updated patch is appended.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: PM / Runtime: Fix pm_runtime_suspended()

There are some situations (e.g. in __pm_generic_call()), where
pm_runtime_suspended() is used to decide whether or not to execute
a device's (system) ->suspend() callback.  The callback is not
executed if pm_runtime_suspended() returns true, but it does so
for devices that don't even support runtime PM, because the
power.disable_depth device field is ignored by it.  This leads to
problems (i.e. devices are not suspened when they should), so rework
pm_runtime_suspended() so that it returns false if the device's
power.disable_depth field is different from zero.

Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
---
 Documentation/power/runtime_pm.txt |    4 ++--
 include/linux/pm_runtime.h         |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/pm_runtime.h
===================================================================
--- linux-2.6.orig/include/linux/pm_runtime.h
+++ linux-2.6/include/linux/pm_runtime.h
@@ -78,7 +78,8 @@ static inline void device_set_run_wake(s
 
 static inline bool pm_runtime_suspended(struct device *dev)
 {
-	return dev->power.runtime_status == RPM_SUSPENDED;
+	return dev->power.runtime_status == RPM_SUSPENDED
+		&& !dev->power.disable_depth;
 }
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
Index: linux-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- linux-2.6.orig/Documentation/power/runtime_pm.txt
+++ linux-2.6/Documentation/power/runtime_pm.txt
@@ -396,8 +396,8 @@ drivers/base/power/runtime.c and include
       zero)
 
   bool pm_runtime_suspended(struct device *dev);
-    - return true if the device's runtime PM status is 'suspended', or false
-      otherwise
+    - return true if the device's runtime PM status is 'suspended' and its
+      'power.disable_depth' field is equal to zero, or false otherwise
 
   void pm_runtime_allow(struct device *dev);
     - set the power.runtime_auto flag for the device and decrease its usage
