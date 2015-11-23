From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v2] i2c: enable i2c device to suspend/resume asynchronously
Date: Mon, 23 Nov 2015 14:25:02 +0800
Message-ID: <5652B13E.6010706@linux.intel.com>
References: <5603978F.8020403@linux.intel.com> <20151020150200.GE5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37160 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbbKWGZG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 23 Nov 2015 01:25:06 -0500
In-Reply-To: <20151020150200.GE5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 10/20/2015 11:02 PM, Wolfram Sang wrote:
> On Thu, Sep 24, 2015 at 02:26:23PM +0800, Fu, Zhonghui wrote:
>> Now, PM core supports asynchronous suspend/resume mode for devices
>> during system suspend/resume, and the power state transition of one
>> device may be completed in separate kernel thread. PM core ensures
>> all power state transition timing dependency between devices. This
>> patch enables i2c device to suspend/resume asynchronously. This will
>> take advantage of multicore and improve system suspend/resume speed.
>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> Does it always work when say a PMIC or clock controller is connected to
> the I2C bus?
Sorry for missing this mail.

Yes, it does not care about what device. The sole difference of asynchronous suspend/resume mode is that the suspend/resume operation of one device is carried out in a separate kernel thread, and PM core ensures all related dependency.


Thanks,
Zhonghui


>
