package widgets.IngresoDenuncios.utilidad
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.Polyline;
	import com.esri.ags.layers.FeatureLayer;
	import com.esri.ags.layers.supportClasses.FeatureEditResult;
	import com.esri.ags.layers.supportClasses.FeatureEditResults;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.core.INavigatorContent;
	import mx.events.FlexEvent;
	import mx.rpc.AsyncResponder;
	
	import widgets.IngresoDenuncios.utilidad.cargarCombos;
	
	public class cliente
	{
		public static var nombre_direccionCliente:String;
		public static var numero_direccionCliente:int;
		public static var id_direccionCliente:int;
		public static var id_rotulo:Number;
		public static var numero_rotulo:String;
		public static var tipo_direccionCliente:String;
		
		public static var geom_ubicacionCliente:MapPoint;
		public static var geom_ubicacionPoste:MapPoint;
		public static var geom_ubicacionDireccion:MapPoint;
		public var token:Object;
		
		public var myCustomer:FeatureLayer = new FeatureLayer(urls.URL_DENUNCIOS_INGRESAR,null,token as String);
		
		public function cliente()
		{
			
		}
		
		public function addCliente(
			nis:int,
			medidor:int, 
			marca_modelo:String,
			direccion:String, 
			tipo_denuncio:String, 
			comuna:String, 
			empresa:String,
			id_poste:String,
			id_direccion:String,
			comentario:String,
			geoCliente:MapPoint): void {
			
			
			var adds:Array=new Array;
			
			var nuevaPoligono:* = new Object;
			nuevaPoligono["nis"]=nis;				
			nuevaPoligono["medidor"]= medidor;
			nuevaPoligono["marca_modelo"]= marca_modelo;
			nuevaPoligono["direccion"]= direccion;
			nuevaPoligono["tipo_denuncio"]= tipo_denuncio;
			nuevaPoligono["comuna"]=comuna;			
			//nuevaPoligono["empresa"]=empresa
			nuevaPoligono["id_poste"]=id_poste;
			nuevaPoligono["id_direccion"]= id_direccion;
			nuevaPoligono["comentario"]= comentario;
			nuevaPoligono["x"]= geoCliente.x;
			nuevaPoligono["y"]= geoCliente.y;
			
			/*Alert.show("nis:" + nis + " med " +medidor + " mar-mo " + marca_modelo + " dir " + direccion + " tipo_denuncio" +
			tipo_denuncio + " comuna " +  comuna + " empresa " + empresa + " id_post " + id_poste + " idDir: " + 
			id_direccion + " comentario: "+ comentario + " " + geoCliente.x);
			*/
			
			//se agrega el punto del cliente con sus datos.
			var graficoEditadoActual:Graphic=new Graphic(geom_ubicacionCliente,null,nuevaPoligono);
			adds[0]=graficoEditadoActual; 
			
			var request:URLRequest = new URLRequest( "http://wsosf.chilquinta:85/chilquinta.ordenes/api/empresa/99/orden/gisred" ); 
			var variables:URLVariables = new URLVariables();
			variables.direccion = "GISWEB - 99 - PRUEBA EVE";
			variables.comentario = comentario;
			variables.id_actividad = 999999;
			request.data = variables;
			request.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				Alert.show("Error"+e);
			}
			
			function loaderCompleteHandler(e:Event):void {
				Alert.show("completo" + e.target.data.toString());
				var responseVars:* = URLVariables( e.target.data );
				
				
			}
			
			//myCustomer.applyEdits(adds,null,null, false,new AsyncResponder(onResult, onFault));
			/*function onResult(result:FeatureEditResults, token:Object = null):void
			{
				
				Alert.show("Denuncio agregado, OID: " + result.addResults[0].objectId.toString() );
				 //agregar lineas 
				//agregarLineas(nis,idDireccion,rotulo,idPoste);
				/*var request:URLRequest = new URLRequest( "http://wsosf.chilquinta:85/chilquinta.ordenes/api/empresa/99/orden/gisred" ); 
				var variables:URLVariables = new URLVariables();
				variables.direccion = "GISWEB "+ result.addResults[0].objectId.toString();
				variables.comentario = comentario;
				variables.id_actividad = 999999;
				request.data = variables;
				request.method = URLRequestMethod.POST;
				var urlLoader:URLLoader = new URLLoader();
				urlLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
				try {
					urlLoader.load(request);
				} catch (e:Error) {
					Alert.show("Error"+e);
				}
				
				function loaderCompleteHandler(e:Event):void {
					var responseVars = URLVariables( e.target.data );
					
					
				}
				*/
			//}
			
		/*	function onFault(info:Object, token:Object = null):void
			{
				Alert.show("Error al agregar denuncio "+info.toString());
			}
			*/
			
		}//add cliente close
		
		
		
	}//class cliente close
	
}// package utilidad close