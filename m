From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 6/7] i3c: master: Add driver for Cadence IP
Date: Thu, 14 Dec 2017 12:25:14 -0800
Message-ID: <8245f2de-eb0a-319b-8f45-d8d5dac36239@infradead.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-7-boris.brezillon@free-electrons.com>
 <d0685c1d-a3ed-b3c1-7e3f-b69b02e8a7be@infradead.org>
 <20171214211722.1c2f269d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171214211722.1c2f269d@bbrezillon>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On 12/14/2017 12:17 PM, Boris Brezillon wrote:
>>> +	events.events = I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR;
>>> +	ret = i3c_master_enec_locked(m, I3C_BROADCAST_ADDR, &events);
>>> +	if (ret)
>>> +		pr_info("Failed to re-enable H-J");  
>> 		Not very good info...
> What do you mean? Is it the H-J that bothers you (I can replace it by
> 'Hot-Join'), or is it something else?

Who is the message for?  If it's for developers, you could use
pr_debug().  If it's for users, it needs more clarity.

Does it print the source of the message? (module name e.g.)
and yes, Hot-Join would be better IMO.

-- 
~Randy
