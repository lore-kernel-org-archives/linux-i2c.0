From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [BUG] i2c_nvidia_gpu takes long time and makes system suspend &
 resume failed with NVIDIA cards
Date: Thu, 2 Apr 2020 13:36:57 +0300
Message-ID: <20200402103657.GE1886416@kuha.fi.intel.com>
References: <CAPpJ_edj++oy7_EDN95tM+BPdYFOztpCrRh-cfzFrY6unJb1Rw@mail.gmail.com>
 <20200402103447.GD1886416@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:53369 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgDBKhA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Apr 2020 06:37:00 -0400
Content-Disposition: inline
In-Reply-To: <20200402103447.GD1886416@kuha.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jian-Hong Pan <jian-hong@endlessm.com>, Ajay Gupta <ajayg@nvidia.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

On Thu, Apr 02, 2020 at 01:34:51PM +0300, Heikki Krogerus wrote:
> You are using an outdated kernel, 5.4.0. Please make sure that you can
> reproduce the issue with mainline, or at least with the longterm
> 5.4.x.

I meant the latest 5.4.x, which today is 5.4.29.


thanks,

-- 
heikki
