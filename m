From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mux-gpio: remove error messages for probe deferrals
Date: Thu, 2 Apr 2015 13:25:37 +0200
Message-ID: <874moyu5zi.fsf@thor.barco.com>
References: <20150330130338.GB5933@ulegcpding.emea.nsn-net.net>
	<551D265C.40703@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551D265C.40703-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> (Alexander Sverdlin's message of "Thu,
	2 Apr 2015 13:22:04 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ioan Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mathias Rulf <mathias.rulf-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "AS" == Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> writes:

Hi,

AS> On 30/03/15 15:03, Ioan Nicu wrote:
>> Probe deferral is not an error case. It happens only when
>> the necessary dependencies are not there yet.
>>
>> The driver core is already printing a message when a driver
>> requests probe deferral, so this can be traced in the logs
>> without these error prints.
>>
>> This patch removes the error messages for these deferral cases.
>>
>> Signed-off-by: Ionut Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

AS> Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
