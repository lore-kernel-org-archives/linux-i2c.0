From: sushil <sushilkdubey@gmail.com>
Subject: Re: ismt-bus completion wait timed out issue
Date: Tue, 5 Jan 2016 16:29:19 +0000 (UTC)
Message-ID: <loom.20160105T172819-335@post.gmane.org>
References: <98891F48-98F3-4E03-B4F7-1B366C602B85@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50016 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbcAFGAG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jan 2016 01:00:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gldi-i2c-1@m.gmane.org>)
	id 1aGh8d-0006gN-BP
	for linux-i2c@vger.kernel.org; Wed, 06 Jan 2016 07:00:03 +0100
Received: from 116.197.184.10 ([116.197.184.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Wed, 06 Jan 2016 07:00:03 +0100
Received: from sushilkdubey by 116.197.184.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Wed, 06 Jan 2016 07:00:03 +0100
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

UHVuZWV0IFNoZW5veSA8cHVuZWV0QC4uLj4gd3JpdGVzOgoKPiAKPiBIZXkgQmlsbCwKPiAKPiBJIHNlZSB0aGF0IHlvdSBhcmUgdGhlIGF1dGhvciBvZiB0aGUgaTJjLWlzbXQgZHJpdmVyIHNvIHRob3VnaHQgd2lsbCBjaGVjayAKd2l0aCB5b3Ugb24gYSBpc3N1ZSB0aGF0IEkgaGF2ZSBiZWVuCj4gc2VlaW5nIG9uIG15IHNldHVwLgo+IAo+IE15IHNldHVwIGhhcyBhbiBJbnRlbCBBdG9tIFMxMjIwIFByb2Nlc3NvciB3aGljaCBoYXMgYSBQTUJVUyBkZXZpY2Ugb24gaXRzIApTTUJVUyAyLjAgY29udHJvbGxlciAoU01CdXPigJRCdXMKPiAwOkQxOTpGMC0xKS4gCj4gCj4gTm93IHdoaWxlIGFjY2Vzc2luZyhyZWFkL3dyaXRlKSB0aGUgUE1CVVMgZGV2aWNlLCBJIHNlZSB0aGUgZm9sbG93aW5nIAplcnJvciBtZXNzYWdlczoKPiBbMTA3OTkuMzMzMDgzXSBpc210X3NtYnVzIDAwMDA6MDA6MTMuMTogY29tcGxldGlvbiB3YWl0IHRpbWVkIG91dAo+IFsxMDgwMC4zMzcwODldIGlzbXRfc21idXMgMDAwMDowMDoxMy4xOiBjb21wbGV0aW9uIHdhaXQgdGltZWQgb3V0Cj4gWzEwODAxLjM0MTA5N10gaXNtdF9zbWJ1cyAwMDAwOjAwOjEzLjE6IGNvbXBsZXRp
 b24gd2FpdCB0aW1lZCBvdXQKPiBbMTA4MDIuMzQ1MTA1XSBpc210X3NtYnVzIDAwMDA6MDA6MTMuMTogY29tcGxldGlvbiB3YWl0IHRpbWVkIG91dAo+IAo+IEFsbCByZWFkL3dyaXRlIGFjY2VzcyB0byB0aGUgZGV2aWNlIGZhaWwgd2hlbiBpdHMgaW4gdGhpcyBzdGF0ZS4gVGhlIGlzc3VlIAppcyBoYXJkIHRvIHJlcHJvZHVjZSBhbmQgaGFwcGVucwo+IG9uY2UgaW4gYSB3aGlsZS4KPiAKPiBJIHRyaWVkIHJtbW9kL21vZHByb2JlIHRoZSBkcml2ZXIsIGJ1dCB0aGF0IGRvZXNuJ3QgaGVscC4gSSBkdW1wZWQgdGhlIApyZWxldmFudCByZWdpc3RlcnMgdGhhdCBhcmUKPiBkZXZfZGJnJ2VkIGluIHRoZSBkcml2ZXIgYW5kIGNvbXBhcmVkIHRoZSBkYXRhIGJldHdlZW4gdGhlIGZhaWxlZCBhbmQgCndvcmtpbmcgY2FzZXMgYW5kIEkgZG9uJ3Qgc2VlIGFueQo+IGRpZmZlcmVuY2UuIAo+IE9uY2UgaW4gYSB3aGlsZSB3aGVuIEkgYW0gaW4gdGhlIGZhaWxlZCBzdGF0ZSwgSSBzZWUgdGhlIEluIFByb2dyZXNzIEJpdCAKKEJpdCAwKSBpbiB0aGUgTVNUUyAoTWFzdGVyIFN0YXR1cwo+IFJlZ2lzdGVyKSBiZWluZyBzZXQgYnV0IGl0cyBub3QgYWx3YXlzIH
 RoZSBjYXNlLgo+IAo+IEhhdmUgeW91IHNlZW4gdGhpcyBpc3N1ZSBiZWZvcmUgPyBBbnkgcG9pbnRlcnMgb24gaG93IHRvIGRlYnVnIHRoaXMgPwo+IAo+IEFwcHJlY2lhdGUgYW55IGhlbHAuCj4gVGhhbmtzCj4gUHVuZWV0LS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtaTJjIiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9ALi4uCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sCj4gCj4gCgpQdW5lZXQsCkRpZCB5b3UgZ2V0IGFueXRoaW5nIG9uIHRoaXM/IApFdmVuIGkgYW0gYWxzbyBmYWNpbmcgc2FtZSBlcnJvciB3aXRoIHNtYnVzIGNvbnRyb2xsZXIgMi4gCgoK
