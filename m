From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware: Implement support for SMBus block
 read and write
Date: Mon, 31 Oct 2016 15:16:29 +0200
Message-ID: <0d9a0ea6-a000-c80d-720e-314319f482ff@linux.intel.com>
References: <1477896677-13085-1-git-send-email-tnhuynh@apm.com>
 <20161031120509.GO23812@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161031120509.GO23812@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, tnhuynh@apm.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On 10/31/2016 02:05 PM, Mika Westerberg wrote:
> On Mon, Oct 31, 2016 at 01:51:17PM +0700, tnhuynh@apm.com wrote:
>> From: Tin Huynh <tnhuynh@apm.com>
>>
>> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
>> However, I2C Designware Core Driver doesn't handle the case at the moment.
>> The below patch supports this feature.
>>
>> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>
> Looks good to me,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
