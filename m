From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 2/2] docs: i2c: dev-interface: document the actual
 implementation
Date: Thu, 23 Jan 2020 14:42:33 +0100
Message-ID: <ffac66db-0b58-b832-f6b5-d1a1da7a1da9@lucaceresoli.net>
References: <20200123105246.67732e33@endymion>
 <20200123111137.5899fa5a@endymion> <20200123110909.GG1105@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:51040 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgAWNmf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Jan 2020 08:42:35 -0500
In-Reply-To: <20200123110909.GG1105@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Lei YU <mine260309@gmail.com>

Hi Jean, Wolfram,

On 23/01/20 12:09, Wolfram Sang wrote:
> On Thu, Jan 23, 2020 at 11:11:37AM +0100, Jean Delvare wrote:
>> The old i2c-dev API based on inline functions is long gone, we have
>> libi2c now which implements the same as real functions and comes with
>> complete API documentation. Update the dev-interface documentation
>> file accordingly to only mention what can be done without the
>> library, and redirect the reader to the libi2c manual page for the
>> rest.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Reported-by: Lei YU <mine260309@gmail.com>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Luca Ceresoli <luca@lucaceresoli.net>
> 
> I wonder if we shouldn't move the 'C library'  paragraph before the 'C
> example'? To make sure people are aware of it (and use it) early before
> digging into the low-level C code?

I agree, it would be better. For the rest it look good.

-- 
Luca
