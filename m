From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Mon, 08 Mar 2010 19:07:08 +0530
Message-ID: <4B94FD84.3060100@mvista.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>	<1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>	<B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>	<225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>	<4B702A17.3070104@mvista.com>	<B85A65D85D7EB246BE421B3FB0FBB59301E2639D67@dbde02.ent.ti.com>	<4B7135B3.9080104@mvista.com> <B85A65D85D7EB246BE421B3FB0FBB59301E263A447@dbde02.ent.ti.com> <F8C55F6A02E92D48BDDFC6048552C6F14E6D9F3F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F8C55F6A02E92D48BDDFC6048552C6F14E6D9F3F-lTKHBJngVwKIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/05/2010 08:50 PM, Griffis, Brad wrote:
>>> Right. I was also hoping to rid of cpu_is_xxx usage. The only other=
 way
>>> I could think of is to add pinmux index into i2c platform data stru=
ct.
>>> What do you think is the best approach?
>>>
>>
>> I think passing pinmux index through platform data is fair.
>>
>> Thanks,
>> Sekhar
>
> I recently was told of a clever solution for this issue which I docum=
ented here:
>
> http://wiki.davincidsp.com/index.php/I2C_Tips#External_Slave_Device_H=
anging_the_Bus_by_Holding_SDA_Low
>
> Basically the solution was to switch to "free data format" and perfor=
m a read.  This will cause the I2C to start toggling SCL.  I mention it=
 here because I think the "free data format" mode is available on most =
processors.  (The only device I know that does NOT support "free data f=
ormat" is OMAP35x.)  You might have a lot less processor-specific code =
with this approach and it would be applicable to more devices.
>
> I don't have any time to write the code/patch myself, but I thought I=
 would at least toss the idea out there.
>
> Brad
>

I did go through your document, but what does "free data format" mean?=20
It would be good to expand the procedure that enables you to move into=20
this mode. If this wouldn't require modfying pinmux settings shouldn't=20
it be part of the core i2c implementation?

At present we follow the i2c spec. recovery procedure which you=20
explained in method 1, and as per AN10216-01 I2C Manual is ...

=95SDA line is then non usable anymore because of the
=93Slave-Transmitter=94mode.
=95Methods to recover the SDA line are:
=96Reset the slave device (assuming the device has a Reset pin)
=96Use a bus recovery sequence to leave the =93Slave-Transmitter=94 mod=
e
=95Bus recovery sequence is done as following:
1-Send 9 clock pulses on SCL line
2-Ask the master to keep SDA High until the =93Slave-Transmitter=94 rel=
eases
the SDA line to perform the ACK operation
3-Keeping SDA High during the ACK means that the =93Master-Receiver=94d=
oes
not acknowledge the previous byte receive
4-The =93Slave-Transmitter=94 then goes in an idle state
5-The master then sends a STOP command initializing completely the bus

Regards,
Philby
