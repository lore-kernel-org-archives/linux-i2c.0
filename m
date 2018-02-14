From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Wed, 14 Feb 2018 17:06:22 +0200
Message-ID: <1351c030-15c9-f95d-084d-3bf62cfe236f@linux.intel.com>
References: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
 <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com>
 <CAE7DoPbMMMbTV5i-fmfhrzKTVoj8Up8aXRYZU9jMh7hKNkkejQ@mail.gmail.com>
 <c5d4a7fc-2d52-9ab5-2a6f-5a5d4e20055c@linux.intel.com>
 <CAE7DoPY8z=dWcTxumkLfwtNhCa-NfEnuXGW=1y2A2B+YzdKjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40742 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030382AbeBNPGB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Feb 2018 10:06:01 -0500
In-Reply-To: <CAE7DoPY8z=dWcTxumkLfwtNhCa-NfEnuXGW=1y2A2B+YzdKjzA@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>

+ José

On 02/13/2018 06:31 PM, Ben Gardner wrote:
>> Can you test does reverting my guessed commit 2702ea7dbec5 ("i2c:
>> designware: wait for disable/enable only if necessary") fix it?
> 
> I verified that reverting 2702ea7dbec5 ("i2c: designware: wait for
> disable/enable only if necessary") also fixes the issue.
> Not waiting when disabling the adapter seems perfectly fine. Not
> waiting when enabling is the problem.
> 
José: There is a regression with above commit and Ben has found a fix 
that brings back waiting when enabling the adapter in transfer start:

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -209,7 +209,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
  	i2c_dw_disable_int(dev);

  	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);

I guess this was just forgotten conversion rather than intentional? At 
least commit log is only about skipping waiting at the end of transaction.

I'd like to avoid full revert first because of Ben's fix I guess still 
keeps the benefit of commit 2702ea7dbec5 and second because of code 
changes revert is also a little bit more labor.

>> For linux-stable it is good info to know exactly the commit causing
>> regression and mark that in your changelog. It allows linux-stable folks to
>> apply fix to earlier kernels and know versions this fix will still apply if
>> cannot apply where regression was introduced. Fox example:
>>
>> Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only
>> if necessary")
>> Cc: linux-stable <stable@vger.kernel.org> # 4.13+
> 
> Do you want me to resubmit this patch with the above lines (Fixes and
> Cc) added or are you willing to add the appropriate lines and take
> care of it?
> I suppose the commit message could use some rewording, now that the
> issue seems a bit clearer.
> 
Yes please. It always good idea to make busy maintainers' life a bit 
more easier :-)

-- 
Jarkko
