From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Subject: Re: Regarding to force bus id for channels of pca954x
Date: Wed, 06 May 2015 10:24:23 -0700
Message-ID: <554A4E47.5070505@rafresearch.com>
References: <CAG+qjJ8qEjzNkjxmUh8yng-Fcxm=_PjteoGqw38QMbP6Xe6wbw@mail.gmail.com> <CAG+qjJ9qWGYe0m9oFDYU-J=ZM2izS=bZeF5=MhDHmzaBPvb3ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080707020203030307080005"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG+qjJ9qWGYe0m9oFDYU-J=ZM2izS=bZeF5=MhDHmzaBPvb3ew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707020203030307080005
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/2015 9:35 AM, os user wrote:
> Hi there,
>
> For some reasons, we need to assign bus id for the channels of I2c mux pca9548.
>
>>From the code, it seems we can use "adap_id" of
>
> struct pca954x_platform_mode {
>    int             adap_id;
>    unsigned int    deselect_on_exit:1;
>    unsigned int    class;
> };
>
> But my questions is, can we assign bus id through device tree and modprobe?
I have been meaning to submit a patch for this to the documentation. 
I'll get to it soon. See attachment on how to assign i2c bus numbers 
from the DT.
-Bob
>
> Thanks.
>
> On Thu, May 7, 2015 at 12:33 AM, os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi there,
>>
>> For some reasons, we need to assign bus id for the channels of I2c mux
>> pca9548.
>>
>>  From the code, it seems we can use "adap_id" of
>>
>> struct pca954x_platform_mode {
>>    int             adap_id;
>>    unsigned int    deselect_on_exit:1;
>>    unsigned int    class;
>> };
>>
>> But my questions is, can we assign bus id through device tree and modprobe?
>>
>> Thanks.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--------------080707020203030307080005
Content-Type: text/plain; charset=windows-1252;
 name="i2c-mux.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="i2c-mux.txt"

Q29tbW9uIGkyYyBidXMgbXVsdGlwbGV4ZXIvc3dpdGNoIHByb3BlcnRpZXMuDQoNCkFuIGky
YyBidXMgbXVsdGlwbGV4ZXIvc3dpdGNoIHdpbGwgaGF2ZSBzZXZlcmFsIGNoaWxkIGJ1c3Nl
cyB0aGF0IGFyZQ0KbnVtYmVyZWQgdW5pcXVlbHkgaW4gYSBkZXZpY2UgZGVwZW5kZW50IG1h
bm5lci4gIFRoZSBub2RlcyBmb3IgYW4gaTJjIGJ1cw0KbXVsdGlwbGV4ZXIvc3dpdGNoIHdp
bGwgaGF2ZSBvbmUgY2hpbGQgbm9kZSBmb3IgZWFjaCBjaGlsZA0KYnVzLg0KDQpSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KLSAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCi0gI3NpemUtY2VsbHMg
PSA8MD47DQoNClJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIGNoaWxkIG5vZGVzOg0KLSAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCi0gI3NpemUtY2VsbHMgPSA8MD47DQotIHJlZyA6IFRoZSBz
dWItYnVzIG51bWJlci4NCg0KT3B0aW9uYWwgcHJvcGVydGllcyBmb3IgY2hpbGQgbm9kZXM6
DQotIE90aGVyIHByb3BlcnRpZXMgc3BlY2lmaWMgdG8gdGhlIG11bHRpcGxleGVyL3N3aXRj
aCBoYXJkd2FyZS4NCi0gQ2hpbGQgbm9kZXMgY29uZm9ybWluZyB0byBpMmMgYnVzIGJpbmRp
bmcNCg0KDQpFeGFtcGxlIDoNCg0KCS8qDQoJICAgQW4gTlhQIHBjYTk1NDggOCBjaGFubmVs
IEkyQyBtdWx0aXBsZXhlciBhdCBhZGRyZXNzIDB4NzANCgkgICB3aXRoIHR3byBOWFAgcGNh
ODU3NCBHUElPIGV4cGFuZGVycyBhdHRhY2hlZCwgb25lIGVhY2ggdG8NCgkgICBwb3J0cyAz
IGFuZCA0Lg0KCSAqLw0KDQoJbXV4QDcwIHsNCgkJY29tcGF0aWJsZSA9ICJueHAscGNhOTU0
OCI7DQoJCXJlZyA9IDwweDcwPjsNCgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCSNzaXpl
LWNlbGxzID0gPDA+Ow0KDQoJCWkyY0AzIHsNCgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
CQkJI3NpemUtY2VsbHMgPSA8MD47DQoJCQlyZWcgPSA8Mz47DQoNCgkJCWdwaW8xOiBncGlv
QDM4IHsNCgkJCQljb21wYXRpYmxlID0gIm54cCxwY2E4NTc0IjsNCgkJCQlyZWcgPSA8MHgz
OD47DQoJCQkJI2dwaW8tY2VsbHMgPSA8Mj47DQoJCQkJZ3Bpby1jb250cm9sbGVyOw0KCQkJ
fTsNCgkJfTsNCgkJaTJjQDQgew0KCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCgkJCXJlZyA9IDw0PjsNCg0KCQkJZ3BpbzI6IGdwaW9AMzggew0K
CQkJCWNvbXBhdGlibGUgPSAibnhwLHBjYTg1NzQiOw0KCQkJCXJlZyA9IDwweDM4PjsNCgkJ
CQkjZ3Bpby1jZWxscyA9IDwyPjsNCgkJCQlncGlvLWNvbnRyb2xsZXI7DQoJCQl9Ow0KCQl9
Ow0KCX07DQoJDQpUaGUgSTJDIHN1YnN5c3RlbSB3aWxsIGFzc2lnbiBuYW1lcyB0byB0aGUg
Y2hpbGQgYnVzc2VzIGR5bmFtaWNhbGx5IGluDQp0aGUgZm9ybSBpMmMtbjsgd2hlcmUgJ24n
IGlzIGFuIGluY3JlbWVudGluZyBudW1iZXIgc3RhcnRpbmcgd2l0aCB0aGUgDQpudW1iZXIg
Zm9sbG93aW5nIHRoZSBwcmV2aW91c2x5IGhpZ2hlc3QgYWxsb2NhdGVkIGJ1cyBudW1iZXIu
DQoNCkFsbGlhc2VzIG1heSBiZSB1c2VkIHRvIGFzc2lnbiBzdGF0aWMgY2hpbGQgYnVzIG5h
bWVzLiBUaGUgYWxpYXMgbmFtZSANCm11c3QgYmUgb2YgdGhlIGZvcm0gaTJjbm4gd2hlcmUg
bm4gaXMgbnVtZXJpYy4gVGhlIG51bWVyaWMgcGFydCAobm4pIGlzDQp1c2VkIHRvIHNldCB0
aGUgYnVzIG51bWJlci4NCg0KRXhhbXBsZSA6DQoNCi8gew0KCWFsaWFzZXMgew0KCQlpMmMx
MCA9ICZpbTA7DQoJCWkyYzExID0gJmltMTsNCgkJaTJjMTIgPSAmaW0yOw0KCQlpMmMxMyA9
ICZpbTM7DQoJCWkyYzE0ID0gJmltNDsNCgkJaTJjMTUgPSAmaW01Ow0KCQlpMmMxNiA9ICZp
bTY7DQoJCWkyYzE3ID0gJmltNzsNCgl9Ow0KfTsNCi4uLg0KCWkyY211eEA3MCB7DQoJIAlj
b21wYXRpYmxlID0gIm54cCxwY2E5NTQ4IjsNCgkgCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
CSAJI3NpemUtY2VsbHMgPSA8MD47DQoJIAlyZWcgPSA8MHg3MD47DQoNCiBpbTA6CWkyY21A
MCB7DQoJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCgkJCSNzaXplLWNlbGxzID0gPDA+Ow0K
CQkJcmVnID0gPDA+Ow0KCQl9Ow0KIGltMToJaTJjbUAxIHsNCgkJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KCQkJI3NpemUtY2VsbHMgPSA8MD47DQoJCQlyZWcgPSA8MT47DQoJCX07DQog
aW0yOglpMmNtQDIgew0KCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCQkjc2l6ZS1jZWxs
cyA9IDwwPjsNCgkJCXJlZyA9IDwyPjsNCgkJfTsNCiBpbTM6CWkyY21AMyB7DQoJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCgkJCSNzaXplLWNlbGxzID0gPDA+Ow0KCQkJcmVnID0gPDM+
Ow0KCQl9Ow0KIGltNDoJaTJjbUA0IHsNCgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkJ
I3NpemUtY2VsbHMgPSA8MD47DQoJCQlyZWcgPSA8ND47DQoJCX07DQogaW01OglpMmNtQDUg
ew0KCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCgkJ
CXJlZyA9IDw1PjsNCgkJfTsNCiBpbTY6CWkyY21ANiB7DQoJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCgkJCSNzaXplLWNlbGxzID0gPDA+Ow0KCQkJcmVnID0gPDY+Ow0KCQl9Ow0KIGlt
NzoJaTJjbUA3IHsNCgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkJI3NpemUtY2VsbHMg
PSA8MD47DQoJCQlyZWcgPSA8Nz47DQoJCX07DQoJIH07DQoNClRoZSBhYm92ZSBmaWxlIHNl
Z21lbnQgY2F1c2VzIHRoZSBjaGlsZCBpMmMgYnVzc2VzIHRvIGJlIG5hbWVkDQppMmMtMTAg
dGhyb3VnaCBpMmMtMTcu
--------------080707020203030307080005--
