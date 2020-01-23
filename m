From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 23/26] docs: i2c: old-module-parameters: fix internal
 hyperlink
Date: Thu, 23 Jan 2020 10:50:59 +0100
Message-ID: <59e5698f-b4df-ca71-a60f-aebdac56873f@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-23-luca@lucaceresoli.net>
 <20200122111625.6685b606@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200122111625.6685b606@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 22/01/20 11:16, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:50:09 +0100, Luca Ceresoli wrote:
>> Use ReST syntax so that a proper hyperlink is generated.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  Documentation/i2c/old-module-parameters.rst | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/i2c/old-module-parameters.rst b/Documentation/i2c/old-module-parameters.rst
>> index 78a6950e5763..0503d2f0b127 100644
>> --- a/Documentation/i2c/old-module-parameters.rst
>> +++ b/Documentation/i2c/old-module-parameters.rst
>> @@ -12,8 +12,7 @@ address), "force" (to forcibly attach the driver to a given device) and
>>  With the conversion of the I2C subsystem to the standard device driver
>>  binding model, it became clear that these per-module parameters were no
>>  longer needed, and that a centralized implementation was possible. The new,
>> -sysfs-based interface is described in the documentation file
>> -"instantiating-devices", section "Method 4: Instantiate from user-space".
>> +sysfs-based interface is described in :doc:`instantiating-devices`.
> 
> I object to removing the reference to the section. I think this is
> saving the reader some time so it is valuable.

I agree, re-added in v2.

-- 
Luca
