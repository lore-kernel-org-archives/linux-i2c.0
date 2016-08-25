From: Peter Rosin <peda@axentia.se>
Subject: Re: [wsa:i2c/for-next 5/14] drivers/gpu/drm/drm_dp_helper.c:810:10:
 error: 'struct i2c_adapter' has no member named 'lock_bus'; did you mean
 'lock_ops'?
Date: Thu, 25 Aug 2016 22:04:58 +0200
Message-ID: <5112628f-7061-89f9-83a6-8786c701ac36@axentia.se>
References: <201608260342.3Jvnwngi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:62189
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756732AbcHYWjy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 18:39:54 -0400
In-Reply-To: <201608260342.3Jvnwngi%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 2016-08-25 21:03, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> head:   431f07e8b0097ded2ffb773d4ea6a797b2bc8bfe
> commit: 24882319480379588d0cced458ed7dd670e93fc7 [5/14] i2c: move locking operations to their own struct
> config: i386-randconfig-s0-201634 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         git checkout 24882319480379588d0cced458ed7dd670e93fc7
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_aux_init':
>>> drivers/gpu/drm/drm_dp_helper.c:810:10: error: 'struct i2c_adapter' has no member named 'lock_bus'; did you mean 'lock_ops'?
>      aux->ddc.lock_bus = lock_bus;
>              ^
>>> drivers/gpu/drm/drm_dp_helper.c:811:10: error: 'struct i2c_adapter' has no member named 'trylock_bus'; did you mean 'lock_ops'?
>      aux->ddc.trylock_bus = trylock_bus;
>              ^
>>> drivers/gpu/drm/drm_dp_helper.c:812:10: error: 'struct i2c_adapter' has no member named 'unlock_bus'; did you mean 'lock_ops'?
>      aux->ddc.unlock_bus = unlock_bus;
>              ^
> 
> vim +810 drivers/gpu/drm/drm_dp_helper.c
> 
> 4f71d0cb Dave Airlie    2014-06-04  804  	mutex_init(&aux->hw_mutex);
> 4f71d0cb Dave Airlie    2014-06-04  805  
> 88759686 Thierry Reding 2013-12-12  806  	aux->ddc.algo = &drm_dp_i2c_algo;
> 88759686 Thierry Reding 2013-12-12  807  	aux->ddc.algo_data = aux;
> 88759686 Thierry Reding 2013-12-12  808  	aux->ddc.retries = 3;
> 88759686 Thierry Reding 2013-12-12  809  
> 0c2f6f1a Chris Wilson   2016-06-17 @810  	aux->ddc.lock_bus = lock_bus;
> 0c2f6f1a Chris Wilson   2016-06-17 @811  	aux->ddc.trylock_bus = trylock_bus;
> 0c2f6f1a Chris Wilson   2016-06-17 @812  	aux->ddc.unlock_bus = unlock_bus;
> acd8f414 Chris Wilson   2016-06-17  813  }
> acd8f414 Chris Wilson   2016-06-17  814  EXPORT_SYMBOL(drm_dp_aux_init);
> acd8f414 Chris Wilson   2016-06-17  815  
> 
> :::::: The code at line 810 was first introduced by commit
> :::::: 0c2f6f1a561136a09c5de91889d0aa35e13f73d4 drm: Pass the drm_dp_aux->hw_mutex to i2c for its locking
> 
> :::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
> :::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Sorry about this, I obviously didn't know about that new user. Should
have looked closer...

Wolfram, should I send an amended patch so that you can replace this
offender and keep things bisect-able, or do you want just a delta?

Cheers,
Peter
