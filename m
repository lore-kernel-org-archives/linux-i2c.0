Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8F2FD69A;
	Sat, 25 Apr 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777153453; cv=none; b=Hl+cKE820snqFeUHBRb9wSBA9/VC6iDxVB3mRjVwbJFaU2nNO0tWDUh59BtVuqVQngYSaSmTRid6eXvP7dolgt42SB3i9gY6a1WAAEoVzoJZp/Tz9nW8QWGQIcdeEbU4NRcSWB1N4TFIp+oTgs31VaBcptZ7V7CVqiMWlKtD/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777153453; c=relaxed/simple;
	bh=BinSz+dpgzFd+Gd7aU/bCkYxTnxk4dLRzzBQ/4mNaPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ91ju+lm4DluZwOS626h/GR0pe/TzgAKE/KcV5+y7m6/MMytJ52d/g88itk5q67XqgQ0EXid4I0svbYUNTN/jyPWNFVkO3iKwgagiTdixgLpwyO4+E/4rtmal+5VRSghefVf4JZgW0ABNUrc8t79SC6ztChL4hwElOWTu2r/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKvXuyo2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKvXuyo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777153452; x=1808689452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BinSz+dpgzFd+Gd7aU/bCkYxTnxk4dLRzzBQ/4mNaPE=;
  b=hKvXuyo2FRnuBtVOd3chG+ZndvAS3rKfCBp8l5k+5026BDmWw/KXee9D
   DHcoLp4jAwTYUvMVVUCtTEe5PuvVKaSScWcUlmn9XK6PKUsAI7I+WQaU2
   s6rmNvm2N+XEwEd9kjQYl2rDN2I74aY6VzzO6Ik35s6tHlkvpg4aWEVO0
   ETsnIDjdZZ5W3PExsUl+mLmwzoMw08o5YMlWHSAATBziu1xgq6OhrEt9/
   J3LCNdgHFoO6dQAHm5UpYHTm3fIkqtwwiUSvElSZh+OFQlBO+RQ2EcCiV
   OicnTqPoH9qE8AhQMSYU0M+njFJ2WLlEAWVlS5cSEevYLhWW77y2f1jan
   w==;
X-CSE-ConnectionGUID: 79iz4yalSryoMq7BtLdxtQ==
X-CSE-MsgGUID: W2Q9hMYBToSjxxa33dcu9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11767"; a="77800907"
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="77800907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 14:44:11 -0700
X-CSE-ConnectionGUID: Jtu4vt9aTYCQqY80EMs5JA==
X-CSE-MsgGUID: rSSPdI5YSFyLQQ9RpJQcKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="256569331"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 14:44:11 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	wsa+renesas@sang-engineering.com,
	syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Subject: Re: [syzbot] [i2c?] WARNING: refcount bug in i2c_get_adapter (2)
Date: Sat, 25 Apr 2026 14:45:15 -0700
Message-ID: <20260425214530.424398-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69e93024.a00a0220.17a17.0031.GAE@google.com>
References: <69e93024.a00a0220.17a17.0031.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This email is created by automation to help kernel developers
deal with a large volume of AI generated bug reports by decoding
oopses into more actionable information.


Decoded Backtrace

0. refcount_warn_saturate -- lib/refcount.c:25 (crash site)

    11  #define REFCOUNT_WARN(str) WARN_ONCE(1, "refcount_t: " str ".\n")
    12
    13  void refcount_warn_saturate(refcount_t *r,
    13                               enum refcount_saturation_type t)
    14  {
    15      refcount_set(r, REFCOUNT_SATURATED);
    16
    17      switch (t) {
    18      case REFCOUNT_ADD_NOT_ZERO_OVF:
    19      case REFCOUNT_ADD_OVF:
    20          REFCOUNT_WARN("saturated; leaking memory");
    21          break;
    22      case REFCOUNT_ADD_UAF:
    23      case REFCOUNT_SUB_UAF:
->  25          REFCOUNT_WARN("addition on 0; use-after-free");
    25          break;
    26      case REFCOUNT_DEC_LEAK:
    27          REFCOUNT_WARN("decrement hit 0; leaking memory");
    28          break;
    29      default:
    30          REFCOUNT_WARN("unknown saturation event!?");
    31      }
    32  }

RBX = 0x2 = REFCOUNT_ADD_UAF, confirming the switch branch taken.


5. kobject_get -- lib/kobject.c:643

   636  struct kobject *kobject_get(struct kobject *kobj)
   637  {
   638      if (kobj) {
   639          if (!kobj->state_initialized)
   640              WARN(1, KERN_WARNING
   641                  "kobject: '%s' (%p): is not initialized, "
   641                  "yet kobject_get() is being called.\n",
   642               kobject_name(kobj), kobj);
-> 643          kref_get(&kobj->kref);   /* unconditional increment */
   644      }
   645      return kobj;
   646  }

kobject_get_unless_zero() (line 649) checks for zero first via
kref_get_unless_zero, but is not used here.


6. i2c_get_adapter -- drivers/i2c/i2c-core-base.c:2612

  2602  struct i2c_adapter *i2c_get_adapter(int nr)
  2603  {
  2604      struct i2c_adapter *adapter;
  2605
  2606      mutex_lock(&core_lock);
  2607      adapter = idr_find(&i2c_adapter_idr, nr);
  2608      if (!adapter)
  2609          goto exit;
  2610
  2611      if (try_module_get(adapter->owner))
->2612          get_device(&adapter->dev);   /* crash: dev refcount == 0 */
  2613      else
  2614          adapter = NULL;
  2615
  2616   exit:
  2617      mutex_unlock(&core_lock);
  2618      return adapter;
  2619  }


7. i2cdev_open -- drivers/i2c/i2c-dev.c:603

   597  static int i2cdev_open(struct inode *inode, struct file *file)
   598  {
   599      unsigned int minor = iminor(inode);
   600      struct i2c_client *client;
   601      struct i2c_adapter *adap;
   602
-> 603      adap = i2c_get_adapter(minor);
   604      if (!adap)
   605          return -ENODEV;
   ...
   618  }


Tentative Analysis

The crash is a "refcount_t: addition on 0; use-after-free" WARNING in
refcount_warn_saturate(), triggered when get_device() is called on an
I2C adapter whose struct device refcount has already reached zero.

The sequence of events:

1. A task opens /dev/i2c-N, which calls i2cdev_open(), which calls
   i2c_get_adapter(minor).

2. i2c_get_adapter() takes core_lock, calls idr_find(), and finds the
   adapter in the IDR (non-NULL).  try_module_get() succeeds.
   get_device(&adapter->dev) is then called.

3. Concurrently, i2c_del_adapter() has already called
   device_unregister(&adap->dev), which drops the device refcount to
   zero.  At this point the adapter is still in the IDR: idr_remove()
   is not called until after wait_for_completion() returns.

4. There is therefore a window where i2c_get_adapter() can find the
   adapter in the IDR and attempt get_device() on an object whose
   kobject refcount is already 0, triggering the WARNING.

The race exists because i2c_del_adapter() removes the adapter from
the IDR only *after* wait_for_completion(), which itself is called
after device_unregister() (which drops the device refcount to zero
when there is only one reference).  i2c_get_adapter() holds core_lock
for its entire body including the get_device() call, but
i2c_del_adapter() releases core_lock before calling
device_unregister(), so the two can execute concurrently.

The bug was introduced by commit 611e12ea0f12 ("i2c: core: manage i2c
bus device refcount in i2c_[get|put]_adapter", 2015), which added
get_device() to i2c_get_adapter() without reordering the idr_remove()
call in i2c_del_adapter().  Before that commit only try_module_get()
was called, so the idr_remove() ordering was inconsequential.


Potential Solution

Move the idr_remove() call in i2c_del_adapter() to before the
device_unregister() call, still under core_lock.  Once the adapter is
removed from the IDR, any concurrent i2c_get_adapter() call will
receive NULL from idr_find() and return -ENODEV.  Callers that already
obtained a device reference before the idr_remove() hold a legitimate
reference; wait_for_completion() will correctly wait for them to
release it via i2c_put_adapter().

Rough patch (against e753c16cb3dd):

  --- a/drivers/i2c/i2c-core-base.c
  +++ b/drivers/i2c/i2c-core-base.c
  @@ i2c_del_adapter
  +    /* Remove from IDR before device_unregister() to prevent a
  +     * concurrent i2c_get_adapter() from calling get_device() on a
  +     * kobject whose refcount has already reached zero.
  +     */
  +    mutex_lock(&core_lock);
  +    idr_remove(&i2c_adapter_idr, adap->nr);
  +    mutex_unlock(&core_lock);
  +
       /* wait until all references to the device are gone ... */
       init_completion(&adap->dev_released);
       device_unregister(&adap->dev);
       wait_for_completion(&adap->dev_released);
   
  -    /* free bus id */
  -    mutex_lock(&core_lock);
  -    idr_remove(&i2c_adapter_idr, adap->nr);
  -    mutex_unlock(&core_lock);
  -


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/69e93024.a00a0220.17a17.0031.GAE_google.com/
Assisted-by: GitHub Copilot linux-kernel-oops-x86.
