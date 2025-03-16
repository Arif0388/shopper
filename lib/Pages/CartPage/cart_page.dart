import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Cart Page',style:Theme.of(context).textTheme.labelLarge),
        centerTitle:true,
      ),
      body:Container(
        child:ListView.builder(
          shrinkWrap:true,
          physics:BouncingScrollPhysics(),
          itemCount:10,
            itemBuilder:(context, index) {
              return Card(
                elevation:5,
                child: ListTile(
                  leading:CircleAvatar(
                    child:Text('N'),
                  ),
                  title:Text('New Dress For Mens',style:Theme.of(context).textTheme.labelLarge),
                  subtitle:Row(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Rs : 2000',style:Theme.of(context).textTheme.labelMedium),
                      CircleAvatar(
                        child:Text('+'),
                      ),
                      CircleAvatar(
                        child:Text('-'),
                      ),
                    ],
                  ),
                ),
              );
            },
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            Text('Total',style:Theme.of(context).textTheme.labelLarge),
            Text('1200',style:Theme.of(context).textTheme.labelLarge),
            Container(
              width:100,
              height:50,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(15),
                color:Theme.of(context).colorScheme.primaryContainer
              ),
              child:Center(child: Text('Checkout')),
            ),
          ],
        ),
      ),
    );
  }
}
