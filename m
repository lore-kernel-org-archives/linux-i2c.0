From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Unmap region obtained
 by pcim_iomap_regions
Date: Fri, 23 Dec 2016 13:27:51 +0200
Message-ID: <f99b90a1-88b3-4971-2a0f-842f36af171a@linux.intel.com>
References: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20161223104449.GV1460@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161223104449.GV1460@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/23/2016 12:44 PM, Mika Westerberg wrote:
> On Fri, Dec 23, 2016 at 03:41:33PM +0530, Arvind Yadav wrote:
>> Release IO memory mapping, if i2c_dw_pci_probe is not successful.
>
> Point of pcim_iomap_regions() is that the regions are released
> automatically. So there is no need for explicit release.
>
Please see commit 76cf3fc844a4 ("i2c-designware-pci: use managed 
functions pcim_* and devm_*") how it simplified error handling here.

-- 
Jarkko
